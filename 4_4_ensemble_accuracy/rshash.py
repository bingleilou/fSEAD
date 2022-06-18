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
import scipy as sp
import os
import sys
from sklearn.metrics import average_precision_score, roc_auc_score
import mmh3
import copy
import pandas as pd
from pyod.utils.utility import argmaxn
from pyod.utils.stat_models import pearsonr
import time
from optparse import OptionParser
from param_gen import *

class rshash():
    def __init__(
            self,
            n_ensemble      = 30      ,
            batch_size      = 100     ,
            num_hash        = 4       ,
            matrix_col      = 100000  ,
            contamination   = 0.1     ,
            feature_dim     = 2       ,
            data_num        = 1000    ,
            sampling_points = 256     ,
            data_name       = 'cardio',
            index           = 0
            ):

        self.n_ensemble = n_ensemble
        self.batch_size = batch_size
        self.scores = []
        self.num_hash = num_hash
        self.matrix_col = matrix_col
        self.contamination = contamination
        self.window_size = batch_size
        
        self.sampling_points = sampling_points
        self.s = min(batch_size, data_num)
        
        self.dim = feature_dim
        self.all_score = []
        self.minimum   = np.zeros(feature_dim)
        self.maximum  = np.zeros(feature_dim)
        self.data_name = data_name
        self.index = index
        
        
    def init_stream(self, X, y):
        self.minimum = X.min(axis=0)
        self.maximum = X.max(axis=0)
        self.filtered_V = []
        self.alpha = np.zeros((self.n_ensemble, self.dim))
        self.f = np.zeros(self.n_ensemble)
        for r in range(self.n_ensemble):
            self.f[r] = np.random.uniform(low=1.0/np.sqrt(self.s), high = 1-1.0/np.sqrt(self.s))
            for i in range(self.dim):
                self.alpha[r][i] = np.random.uniform(low=0, high = self.f[r])

            # Select integer r (dimensions) to be extracted from dataset
            low = 1+0.5 * (np.log(self.s)/np.log(max(2,1.0/self.f[r])))
            high = np.log(self.s)/np.log(max(2,1.0/self.f[r]))
            rr = int(np.random.uniform(low, high))
            if rr > self.dim:
                rr = self.dim
            V = np.random.choice(range(self.dim), rr, replace=False)
            V = V[np.where(self.minimum[V] != self.maximum[V])]
            V = np.array(V)
            self.filtered_V.append(V)
            #Normalize X
            norm_X =  (X -  self.minimum)/( self.maximum -   self.minimum)
            #Setting range(S) norm value to 0
            norm_X[np.abs(norm_X) == np.inf] = 0
        
        #reset-1
        self.windowIdx = int(0)
        self.windows_hash           = np.zeros((self.n_ensemble, self.num_hash, self.sampling_points), dtype=int)
        self.windows_c              = np.zeros((self.n_ensemble, self.num_hash, self.sampling_points), dtype=int)
        self.counts            = np.zeros((self.n_ensemble, self.num_hash, self.matrix_col), dtype = int)
        self.windowIdx_score_batch = int(0)
        
        model_scores_for_range = []
        self.pp_data = X[:self.sampling_points,:]
        for idx in range(0, self.sampling_points):
            self.fit_stream_continus_init(self.pp_data[idx])
            model_scores_for_range.append(self.score_stream())
        self.peak = np.max(np.array(model_scores_for_range))
        self.bottom = np.min(np.array(model_scores_for_range))
        
        #reset-2
        self.windowIdx = int(0)
        self.windows_hash           = np.zeros((self.n_ensemble, self.num_hash, self.sampling_points), dtype=int)
        self.windows_c              = np.zeros((self.n_ensemble, self.num_hash, self.sampling_points), dtype=int)
        self.counts            = np.zeros((self.n_ensemble, self.num_hash, self.matrix_col), dtype = int)
        self.windowIdx_score_batch = int(0)
        
        ########################################
        #              print params            #
        ########################################
        
        data_path = "params/rshash/{data_name}/".format(data_name=self.data_name)
        data_name = "params_gcc_rshash_{data_name}_E{ensemble}_M{i}.h".format(data_name=self.data_name, ensemble=self.n_ensemble,i=self.index)
        print_params_gcc_rshash(data_path, data_name, self.n_ensemble, self.dim, self.batch_size, self.num_hash, self.matrix_col, self.alpha, (1.0/self.f), self.minimum, 1.0/(self.maximum-self.minimum), self.bottom, 1.0/(self.peak-self.bottom))

        return 0
    
    def fit_stream_continus_init(self, X):
        X_normalized = (X - self.minimum)/(self.maximum - self.minimum)
        X_normalized[np.abs(X_normalized) == np.inf] = 0
        score_instance = 0
        
        for r in range(self.n_ensemble):
            ##### ------ small n_ensemble ------ #####
            Y = -1 * np.ones(self.dim)
            for j in range(self.dim):
                #if j in self.filtered_V[r]:
                Y[j] = np.floor((X_normalized[j]+self.alpha[r][j])/float(self.f[r]))
            
            vec = Y.astype(np.int)
            vec_r = np.insert(vec, 0, r)
            mod_entry = vec_r.astype(np.int)
            
            c = np.zeros(self.num_hash, dtype = int)
            for row in range(self.num_hash):
                hash_code = self.hash_fun(vec, row)
                
                c[row] = self.counts[r][row][hash_code]
                self.counts[r][row][hash_code] += 1
                
                col_to_remove_1 = self.windows_hash[r][row][self.windowIdx]
                cFromWin    = self.windows_c[r][row][self.windowIdx]
                
                self.counts[r][row][col_to_remove_1] -= cFromWin
                
                self.windows_hash[r][row][self.windowIdx]=hash_code
                self.windows_c[r][row][self.windowIdx]=1
            min_c = min(c)
            c = -np.log2(1+min_c)
            score_instance = score_instance + c
            
        self.windowIdx = self.windowIdx + 1
        if self.windowIdx>=self.batch_size:
            self.windowIdx = 0
        else:
            self.windowIdx = self.windowIdx

        self.stream_score = score_instance / self.n_ensemble
        return self
    
    def score_stream(self):
        return self.stream_score
    
    
    def hash_fun(self, s, k):
        hash_value = int(mmh3.hash(s, signed=False, seed=k))% self.matrix_col
        return hash_value

if __name__ == '__main__':
    optParser = OptionParser()
    optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
    (options, args) = optParser.parse_args()
    data_name       = options.data_name

    #print("#========================  hyper-params  =======================#")
    batch_size      = 128
    num_hash = 2
    matrix_col = 128
    
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

    E_list = [25,50,75,100,125,150,175]
    run_num = 10
    for i in range(len(E_list)):
        e = E_list[i]
        print("n_ensemble = ",e)
        for i in tqdm(range(run_num), desc='Streaming Points...'):
            model = rshash(n_ensemble      = e,
                  batch_size       = batch_size,
                  num_hash         = num_hash,
                  matrix_col       = matrix_col,
                  contamination    = contamination, 
                  feature_dim      = n_features,
                  data_num         = X_train.shape[0],
                  sampling_points  = sampling_points,
                  data_name        = data_name,
                  index            = i+1)
            model.init_stream(X_train, y_train)
            
            
            
            