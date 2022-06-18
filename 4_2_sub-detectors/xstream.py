import numpy as np
from pysad.utils import Data
from sklearn.utils import shuffle
from tqdm import tqdm
import random
import sys
from sklearn.metrics import average_precision_score, roc_auc_score
import mmh3
from numpy import percentile
import copy
import pandas as pd
from pyod.utils.utility import argmaxn
from pyod.utils.stat_models import pearsonr
import time
from optparse import OptionParser
from param_gen import *

class StreamhashProjection:
    def __init__(self, n_components, density=1/3.0, random_seed = None):
        self.keys = np.arange(0, n_components, 1)
        self.constant = np.sqrt(1./density) / np.sqrt(n_components)
        self.density = density
        random.seed(random_seed)
        
    def fit_transform(self, X, feature_names = None):
        ndim = X.shape[1]
        if feature_names is None:
            feature_names = [str(i) for i in range(ndim)]
        
        R = np.array([self._hash_string(k,f) for f in feature_names for k in self.keys])
        Y = np.dot(X, R.T)
        return Y
    
    def _hash_string(self, k, f):
        mod_entry = np.insert(f, 0, k)
        hash_value = int(mmh3.hash(f, signed=False, seed=k))/(2.0**32-1)
        f = self.density
        if hash_value <= f/2.0:
            return -1 * self.constant
        elif hash_value < f:
            return self.constant
        else:
            return 0 
        
class xstream:
    def __init__(
            self, 
            batch_size      = 100    ,
            sampling_points = 256    ,
            dim             = 2      ,
            matrix_col      = 100000 ,
            k               = 50     ,
            nchains         = 30     ,
            depth           = 25     ,
            contamination   = 0.1    ,
            seed            = 66     ,
            data_name       = 'cardio',
            index           = 0
            ):
        self.batch_size = batch_size
        self.sampling_points = sampling_points
        self.window_size = batch_size
        self.dim = dim
        self.nchains = nchains
        self.depth = int(depth)
        self.chains = []
        self.contamination = contamination
        self.projector = StreamhashProjection(n_components = k, density = 1/3.0, random_seed = seed)
        self.feature_names = [str(i) for i in range(self.dim)]
        self.keys = np.arange(0, k ,1)
        self.R = np.array([[self.projector._hash_string(k, f) for f in self.feature_names] for k in self.keys])
        self.k = int(k)
        self.matrix_col = matrix_col
        self.data_name = data_name
        self.index = index
        
    def init_stream(self, X, y):
        self.fs_s = np.zeros((self.nchains, self.depth), dtype=np.int)
        self.shift = np.zeros((self.nchains, self.k))
        
        deltamax = np.ones(self.k)
        for r in range(self.nchains):
            self.fs_s[r] = [np.random.randint(0, len(deltamax)) for d in range(self.depth)]
        
        projected_X = np.dot(X, self.R.T)
        deltamax = np.ptp(projected_X, axis=0)/2.0
        deltamax[deltamax==0] = 1.0
        self.deltamax = deltamax
        
        for r in range(self.nchains):
            self.shift[r] = np.random.rand(self.k) * self.deltamax
        
        #reset-1
        self.counts = np.zeros((self.nchains, self.depth, self.matrix_col), dtype = int)
        self.windowIdx = int(0)
        self.windows_hash = np.zeros((self.nchains, self.depth, self.sampling_points), dtype=int)
        self.windows_c = np.zeros((self.nchains, self.depth, self.sampling_points), dtype=int)
        self.windowIdx_score_batch = int(0)
        self.windows_score_batch  = np.zeros(self.sampling_points, dtype=float)

        model_scores_for_range = []
        self.pp_data = X[:self.sampling_points,:]
        for idx in range(0, self.sampling_points):
            self.fit_stream_continus_init(self.pp_data[idx])
            model_scores_for_range.append(self.score_stream())
        self.peak = np.max(np.array(model_scores_for_range))
        self.bottom = np.min(np.array(model_scores_for_range))
        
        #reset-2
        self.counts            = np.zeros((self.nchains, self.depth, self.matrix_col), dtype = int)
        self.windowIdx = int(0)
        self.windows_hash = np.zeros((self.nchains, self.depth, self.sampling_points), dtype=int)
        self.windows_c = np.zeros((self.nchains, self.depth, self.sampling_points), dtype=int)
        self.windowIdx_score_batch = int(0)
        self.windows_score_batch  = np.zeros(self.sampling_points, dtype=float)
        
        ########################################
        #              print params            #
        ########################################
        data_path = "params/xstream/{data_name}/".format(data_name=self.data_name)
        data_name = "params_gcc_xstream_{data_name}_E{ensemble}_M{i}.h".format(data_name=self.data_name, ensemble=self.nchains,i=self.index)
        print_params_gcc_xstream(data_path, data_name, self.nchains, self.dim, self.batch_size, self.k, self.depth, self.matrix_col, self.R.T, self.fs_s, (1.0/self.deltamax), -(self.shift/self.deltamax), self.shift, self.bottom, 1.0/(self.peak-self.bottom))
        
        return 0
    
    def fit_stream_continus_init(self, X, y=None):
        score_instance = 0
        Y = np.dot(X, self.R.T).ravel()
        for r in range(self.nchains):
            ##### ------ nchains ------ #####
            scores = np.zeros(self.depth)
            perbins = np.zeros(Y.shape, dtype = np.float)
            depthcount = np.zeros(len(self.deltamax), dtype = np.int)
            for depth in range(self.depth):
                f = self.fs_s[r][depth]
                depthcount[f] += 1
                if depthcount[f] == 1:
                    perbins[f] = (Y[f] + self.shift[r][f] )/ self.deltamax[f]
                else:
                    perbins[f] = 2.0*perbins[f]  -  self.shift[r][f] / self.deltamax[f]
                    
                perbins_int = np.floor(perbins).astype(np.int)
                hash_code = self.my_hash0(perbins_int)
                c = self.counts[r][depth][hash_code]
                self.counts[r][depth][hash_code] += 1
                col_to_remove_1 = self.windows_hash[r][depth][self.windowIdx]
                cFromWin    = self.windows_c[r][depth][self.windowIdx]
                self.counts[r][depth][col_to_remove_1] -= cFromWin
                self.windows_hash[r][depth][self.windowIdx]=hash_code
                self.windows_c[r][depth][self.windowIdx]=1
                scores[depth] = np.log2(1.0 + c) + (depth + 1)
            s = -min(scores)
            score_instance = score_instance + s
            
        self.windowIdx = self.windowIdx + 1
        if self.windowIdx>=self.batch_size:
            self.windowIdx = 0
        else:
            self.windowIdx = self.windowIdx
        
        self.stream_score = score_instance / self.nchains
        return self
    
    def score_stream(self):
        return self.stream_score
    
    def my_hash0(self, x):
        hash_python = int(mmh3.hash(x, signed=False, seed=0))/(2.0**32-1) 
        hash_python = int(hash_python * self.matrix_col)
        return hash_python
        
if __name__ == '__main__':
    
    optParser = OptionParser()
    optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
    (options, args) = optParser.parse_args()
    data_name       = options.data_name
    
    #print("#========================  hyper-params  =======================#")
    batch_size      = 128
    depth           = 2 # hash num
    k               = 20  # the number of random projection (k<d)
    matrix_col      = 128

    #print("#=========================  real data  =========================#")
    data = Data("data")
    input_data = "{data_name}.mat".format(data_name=data_name)
    X_train, y_train = data.get_data(input_data)  # Load data.
    X_train, y_train = shuffle(X_train, y_train, random_state=67)  # Shuffle data.
    
    data_gcc_path = "./gcc/data_gcc/"
    save_X_name = "{data_name}_X".format(data_name=data_name)
    save_y_name = "{data_name}_y".format(data_name=data_name)
    np.savetxt(data_gcc_path + save_X_name, X_train, delimiter=' ')
    np.savetxt(data_gcc_path + save_y_name, y_train, delimiter=' ')
    
    sampling_points = int(X_train.shape[0]/10)
    contamination = y_train.sum() / len(y_train)
    n_features = X_train.shape[1]
    
    E_list = [2,3,4,5,6,7,8,9,10,20,40,60,80,100,120,140,160,180,200]
    run_num = 10
    for i in range(len(E_list)):
        e = E_list[i]
        print("n_ensemble = ",e)
        for i in tqdm(range(run_num), desc='Streaming Points...'):
            model = xstream(batch_size      = batch_size,
                        sampling_points = sampling_points,
                        dim             = n_features, 
                        k               = k, 
                        nchains         = e, 
                        depth           = depth, 
                        matrix_col      = matrix_col,
                        contamination   = contamination,
                        data_name       = data_name,
                        index           = i+1)
            model.init_stream(X_train, y_train)
