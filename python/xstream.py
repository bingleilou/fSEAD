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
from param_gen import *
import time
from optparse import OptionParser

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
            save_en         = '0'
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
        self.save_en = save_en
        
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
        self.index = int(0)
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
        self.counts = np.zeros((self.nchains, self.depth, self.matrix_col), dtype = int)
        self.index = int(0)
        self.windowIdx = int(0)
        self.windows_hash = np.zeros((self.nchains, self.depth, self.sampling_points), dtype=int)
        self.windows_c = np.zeros((self.nchains, self.depth, self.sampling_points), dtype=int)
        self.windowIdx_score_batch = int(0)
        self.windows_score_batch  = np.zeros(self.sampling_points, dtype=float)
        
        ########################################
        #              print params            #
        ########################################
        if self.save_en != '0':
            data_path = "params/xstream/{data_name}/".format(data_name=self.data_name)
            RT_print           = self.R.T
            fs_print           = self.fs_s
            deltamax_print     = (1.0/self.deltamax)
            shift_deltamax     = -(self.shift/self.deltamax)
            shift_print        = self.shift
            bottom_print       = self.bottom
            peak_bottom_print  = 1.0/(self.peak-self.bottom)
            param_name_hls = "params_xstream_E{ensemble}.h".format(ensemble=self.nchains)
            param_name_gcc = "params_gcc_xstream_E{ensemble}.h".format(ensemble=self.nchains)
            print_params_hls_xstream(data_path, param_name_hls, self.nchains, self.dim, self.batch_size, self.k, self.depth, self.matrix_col, RT_print, fs_print, deltamax_print, shift_deltamax, shift_print, bottom_print, peak_bottom_print)
            print_params_gcc_xstream(data_path, param_name_gcc, self.nchains, self.dim, self.batch_size, self.k, self.depth, self.matrix_col, RT_print, fs_print, deltamax_print, shift_deltamax, shift_print, bottom_print, peak_bottom_print)
            base_num = int(self.nchains/7)
            for r in range(7):
                param_name_hls = "params_xstream_E{ensemble}C{batch}.h".format(ensemble=base_num, batch=r+1)
                print_params_hls_xstream(data_path, param_name_hls, self.nchains, self.dim, self.batch_size, self.k, self.depth, self.matrix_col, RT_print, fs_print[r*base_num:(r+1)*base_num], deltamax_print, shift_deltamax[r*base_num:(r+1)*base_num], shift_print[r*base_num:(r+1)*base_num], bottom_print, peak_bottom_print)
                
        return 0
    
    def fit_batch(self, X):
        Y = np.dot(X, self.R.T).ravel()
        for r in range(self.nchains):
            ##### ------ n_ensemble ------ #####
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

                self.windows_hash[r][depth][self.windowIdx]=hash_code
                self.windows_c[r][depth][self.windowIdx]=1

                # update the counts
                self.counts[r][depth][hash_code] += 1
            
        self.windowIdx = self.windowIdx + 1
        if self.windowIdx>=self.batch_size:
            self.windowIdx = 0
        else:
            self.windowIdx = self.windowIdx
        
        return self
    
    def score_batch(self, X):
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
                # get the scores
                scores[depth] = self.counts[r][depth][hash_code]

            depths = np.array([d for d in range(1, self.depth+1)])
            c = -min(np.log2(1.0 + scores) + depths)
            score_instance += c
            
        ##### ------ COMMON ------ #####
        self.stream_score = score_instance /self.nchains
        
        self.windowIdx_score_batch = self.windowIdx_score_batch + 1
        if self.windowIdx_score_batch>=self.batch_size:
            self.windowIdx_score_batch = 0
        else:
            self.windowIdx_score_batch = self.windowIdx_score_batch
            
        return self
    
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
    
    def fit_stream_continus(self, X, y=None):
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
        self.stream_score_norm = (score_instance/self.nchains - self.bottom) / (self.peak - self.bottom)
        return self
    
    def my_hash0(self, x):
        hash_python = int(mmh3.hash(x, signed=False, seed=0))/(2.0**32-1) 
        hash_python = int(hash_python * self.matrix_col)
        return hash_python
    
    def score_stream(self):
        return self.stream_score
    
    def score_stream_norm(self):
        return self.stream_score_norm
    
    def _process_decision_scores(self, scores):
        self.threshold = percentile(scores, 100*(1-self.contamination))
        self.labels_ = (scores > self.threshold).astype('int').ravel()
        return self
        
if __name__ == '__main__':
    
    optParser = OptionParser()
    optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
    optParser.add_option('--save_en', action='store',type='string',dest='save_en', default = '0',help='save_en')
    (options, args) = optParser.parse_args()
    data_name       = options.data_name
    save_en         = options.save_en
    
    print("#========================  hyper-params  =======================#")
    nchains         = 140
    batch_size      = 128
    depth           = 2 # hash num
    k               = 20  # the number of random projection (k<d)
    matrix_col      = 128
    print("nchains = ",nchains)
    print("k = ",k)
    print("depth = ",depth)
    print("batch_size = ",batch_size)
    print("matrix_col = ",matrix_col)
    
    print("#=========================  real data  =========================#")
    data = Data("data")
    input_data = "{data_name}.mat".format(data_name=data_name)
    X_train, y_train = data.get_data(input_data)  # Load data.
    X_train, y_train = shuffle(X_train, y_train, random_state=67)  # Shuffle data.
    
    if save_en != '0':
        data_hls_path = "./../fpga/data_hls/xstream/"
        save_X_name = "{data_name}_X".format(data_name=data_name)
        save_y_name = "{data_name}_y".format(data_name=data_name)
        np.savetxt(data_hls_path + save_X_name, X_train, delimiter=',')
        np.savetxt(data_hls_path + save_y_name, y_train, delimiter=',')
        
        data_gcc_path = "./../gcc/data_gcc/xstream/"
        save_X_name = "{data_name}_X".format(data_name=data_name)
        save_y_name = "{data_name}_y".format(data_name=data_name)
        np.savetxt(data_gcc_path + save_X_name, X_train, delimiter=' ')
        np.savetxt(data_gcc_path + save_y_name, y_train, delimiter=' ')
    
    print("X_train.shape = ",X_train.shape)
    print("y_train.shape = ",y_train.shape)
    sampling_points = int(X_train.shape[0]/10)
    contamination = y_train.sum() / len(y_train)
    print("contamination = ",contamination)
    n_features = X_train.shape[1]
    model = xstream(batch_size      = batch_size,
                    sampling_points = sampling_points,
                    dim             = n_features, 
                    k               = k, 
                    nchains         = nchains, 
                    depth           = depth, 
                    matrix_col      = matrix_col,
                    contamination   = contamination,
                    data_name       = data_name,
                    save_en         = save_en)

    model_labels = []
    model_scores = []

    model.init_stream(X_train, y_train)
    print("#===================   Start Streaming Test   ==================#")
    start_time = time.time()
    for idx in tqdm(range(0, X_train.shape[0]), desc='Streaming Points...'):
        model.fit_stream_continus(X_train[idx])
        model_scores.append(model.score_stream())
    end_time = time.time()
    timecost = end_time - start_time
    
    model_scores = (np.array(model_scores).ravel() - model.bottom)/(model.peak- model.bottom)
    auroc_score = roc_auc_score(y_train[batch_size:],model_scores[batch_size:])
    model._process_decision_scores(model_scores)
    y_train_pred_label = model.labels_
    auroc_label = roc_auc_score(y_train[batch_size:],y_train_pred_label[batch_size:])
    print("AUC-score         : ", auroc_score)
    print("AUC-label         : ", auroc_label)
    print("timecost: ", timecost)
    print()
    
    if save_en != '0':
        data_path = "scores/xstream/"
        save_score_name = "score_{data_name}".format(data_name=data_name)
        np.savetxt(data_path + save_score_name, model_scores, delimiter=',')

