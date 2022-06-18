import numpy as np
from array import array
from random import randint
from math import log, e, ceil
from pysad.evaluation import AUROCMetric
from pysad.utils import ArrayStreamer
from pysad.utils import Data
from sklearn.utils import shuffle
from tqdm import tqdm
from numpy import percentile
from sklearn.metrics import average_precision_score, roc_auc_score
import copy
import pandas as pd
from pyod.utils.utility import argmaxn
from scipy.stats import pearsonr
import time
from optparse import OptionParser
from param_gen import *

class loda():
    def __init__(
            self, 
            n_ensemble       = 30     ,
            batch_size       = 256    ,
            n_bins           = 20     ,
            contamination    = 0.1    ,
            sparsity         = 'dense',
            frature_dim      = 2      ,
            data_num         = 1000   ,
            bin_width        = 0.01   ,
            matrix_col       = 10000  ,
            sampling_points  = 250    ,
            data_name       = 'cardio',
            index            = 0
            ):
            
            self.n_ensemble = n_ensemble
            self.batch_size = batch_size
            self.n_bins = n_bins
            self.contamination = contamination
            self.dim = frature_dim
            self.sparsity = sparsity
            self.data_name = data_name
            self.index = index
            
            self.sampling_points = sampling_points
            
            
            self.projections     = np.random.randn(self.n_ensemble, frature_dim)
            self.projections_use  = np.zeros((self.n_ensemble, frature_dim))
            self.projections_norm = np.zeros((self.n_ensemble, frature_dim))
            
    def init_stream(self, X, y):
        ########################################
        #               common                 #
        ########################################
        if  self.sparsity == 'dense':
            self.sparsity=0
        elif self.sparsity == 'sparse':
            self.sparsity=1 - 1/np.sqrt(self.dim)
        
        for i in range(self.n_ensemble):
            self.projections_norm[i,:] = self.projections[i,:] / np.linalg.norm(self.projections[i,:])
        if self.sparsity>0 and self.sparsity<1:
            for i in range(self.n_ensemble_gt):
                rands = np.random.permutation(self.dim)[: int(self.sparsity* self.dim)]
                self.projections_use[i,:] = copy.deepcopy(self.projections_norm[i,:])
                self.projections_use[i, rands] = 0.
        else:
            self.projections_use = copy.deepcopy(self.projections_norm)
            
        
        first_batch_X = X[:self.sampling_points,:]
        self.first_batch_X_projected = self.projections_use.dot(X.T) #shape = (n_ensemble_gt, n)
        range_X_projected = np.ptp(self.first_batch_X_projected, axis=1)
        
        self.delta = range_X_projected / self.n_bins
        self.delta = np.reshape(self.delta, (len(self.delta),1))
        self.min_X_projected = np.min(self.first_batch_X_projected, axis=1)
        self.min_X_projected = np.reshape(self.min_X_projected, (len(self.min_X_projected),1))
        
        self.idxs = np.around((self.first_batch_X_projected - self.min_X_projected)/self.delta)
        self.nBins = int(np.max(self.idxs) + 1)
        
        #reset-1
        self.H = np.zeros((self.n_ensemble, self.nBins), dtype=int)
        self.N = np.zeros(self.n_ensemble, dtype=int)
        self.windows_idx = np.zeros((self.n_ensemble, self.sampling_points), dtype=int)
        self.windows_c = np.zeros((self.n_ensemble, self.sampling_points), dtype=int)
        self.windowIdx = int(0)
        self.windowIdx_score_batch = int(0)
        
        model_scores_for_range = []
        self.pp_data = X[:self.sampling_points,:]
        for idx in range(0, self.sampling_points):
            self.fit_stream_continus_init(self.pp_data[idx])
            model_scores_for_range.append(self.score_stream())
        self.peak = np.max(np.array(model_scores_for_range))
        self.bottom = np.min(np.array(model_scores_for_range))
        
        #reset-2
        self.H = np.zeros((self.n_ensemble, self.nBins), dtype=int)
        self.N = np.zeros(self.n_ensemble, dtype=int)
        self.windows_idx = np.zeros((self.n_ensemble, self.sampling_points), dtype=int)
        self.windows_c = np.zeros((self.n_ensemble, self.sampling_points), dtype=int)
        
        ########################################
        #              print params            #
        ########################################
        data_path = "params/loda/{data_name}/".format(data_name=self.data_name)
        min_X_print       = self.min_X_projected.ravel()
        projections_print = self.projections_use
        delta_print       = (1/self.delta).ravel()
        bottom_print      = self.bottom
        peak_bottom       = 1.0/(self.peak-self.bottom)
        data_name = "params_gcc_loda_{data_name}_E{ensemble}_M{i}.h".format(data_name=self.data_name, ensemble=self.n_ensemble,i=self.index)
        print_params_gcc_loda(data_path, data_name, self.n_ensemble, self.dim, self.batch_size, self.n_bins, min_X_print, projections_print, delta_print, bottom_print, peak_bottom)

        return 0
    
    def fit_stream_continus_init(self, X):
        score_instance = 0
        for r in range(self.n_ensemble): 
            ##### ------ n_ensemble ------ #####
            projected_X = self.projections_use[r,:].dot(X) 
            idx = int((projected_X - self.min_X_projected[r])/self.delta[r])
            if idx >= self.nBins - 1:
                idx = self.nBins - 1
            if idx <= 0:
                idx = 0
            
            if self.H[r][idx] > 0:
                c = -np.log2(self.H[r][idx]/self.batch_size)
            else:
                c = 15.0
            
            score_instance += c
                
            self.H[r][idx] += 1
            self.N[r] += 1

            idxFromWin = self.windows_idx[r][self.windowIdx]
            cFromWin    = self.windows_c[r][self.windowIdx]

            self.H[r][idxFromWin]   -=  cFromWin
            self.N[r]               -=  cFromWin
            
            self.windows_idx[r][self.windowIdx]=idx
            self.windows_c[r][self.windowIdx]=1
            
        self.windowIdx = self.windowIdx + 1
        if self.windowIdx>=self.batch_size:
            self.windowIdx = 0
        else:
            self.windowIdx = self.windowIdx
        
        self.stream_score = score_instance / self.n_ensemble
        return self
    
    def score_stream(self):
        return self.stream_score
    
if __name__ == '__main__':
    optParser = OptionParser()
    optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
    (options, args) = optParser.parse_args()
    data_name       = options.data_name
    
    #print("#========================  hyper-params  =======================#")
    batch_size      = 128
    
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
            model = loda(n_ensemble   = e,
                 batch_size      = batch_size,
                 contamination   = contamination, 
                 sampling_points = sampling_points,
                 frature_dim     = n_features,
                 data_name       = data_name,
                 index           = i+1)
            model.init_stream(X_train, y_train)

    

    
