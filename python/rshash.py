import numpy as np
from array import array
from random import randint
from math import log, e, ceil
from pysad.utils import Data
from sklearn.utils import shuffle
from tqdm import tqdm
from numpy import percentile
from param_gen import *
import scipy as sp
import os
import sys
from sklearn.metrics import average_precision_score, roc_auc_score
import mmh3
import copy
import pandas as pd
import time
from optparse import OptionParser


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
            save_en         = '0'
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
        self.save_en = save_en
        
        
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
        
        
        self.windowIdx = int(0)
        self.windows_hash           = np.zeros((self.n_ensemble, self.num_hash, self.sampling_points), dtype=int)
        self.windows_c              = np.zeros((self.n_ensemble, self.num_hash, self.sampling_points), dtype=int)
        self.counts            = np.zeros((self.n_ensemble, self.num_hash, self.matrix_col), dtype = int)
        self.windowIdx_score_batch = int(0)

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
        if self.save_en != '0':
            data_path = "params/rshash/{data_name}/".format(data_name=self.data_name)
            alpha_print        = self.alpha
            f_print            = (1.0/self.f)
            minimum_print      = self.minimum
            max_min_print      = 1.0/(self.maximum-self.minimum)
            bottom_print       = self.bottom
            peak_bottom_print  = 1.0/(self.peak-self.bottom)
            param_name_hls = "params_rshash_E{ensemble}.h".format(ensemble=self.n_ensemble)
            param_name_gcc = "params_gcc_rshash_E{ensemble}.h".format(ensemble=self.n_ensemble)
            print_params_hls_rshash(data_path, param_name_hls, self.n_ensemble, self.dim, self.batch_size, self.num_hash, self.matrix_col, alpha_print, f_print, minimum_print, max_min_print, bottom_print, peak_bottom_print)
            print_params_gcc_rshash(data_path, param_name_gcc, self.n_ensemble, self.dim, self.batch_size, self.num_hash, self.matrix_col, alpha_print, f_print, minimum_print, max_min_print, bottom_print, peak_bottom_print)
            base_num = int(self.n_ensemble/7)
            for r in range(7):
                param_name_hls = "params_rshash_E{ensemble}C{batch}.h".format(ensemble=base_num, batch=r+1)
                print_params_hls_rshash(data_path, param_name_hls, base_num, self.dim, self.batch_size, self.num_hash, self.matrix_col, alpha_print[r*base_num:(r+1)*base_num], f_print[r*base_num:(r+1)*base_num], minimum_print, max_min_print, bottom_print, peak_bottom_print)
                
        return 0
    
    def fit_batch(self, X):
        X_normalized = (X - self.minimum)/(self.maximum - self.minimum)
        X_normalized[np.abs(X_normalized) == np.inf] = 0
        for r in range(self.n_ensemble):
            ##### ------ n_ensemble ------ #####
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
                # update the counts
                self.counts[r][row][hash_code] += 1

                self.windows_hash[r][row][self.windowIdx]=hash_code
                self.windows_c[r][row][self.windowIdx]=1
                
        self.windowIdx = self.windowIdx + 1
        if self.windowIdx>=self.batch_size:
            self.windowIdx = 0
        else:
            self.windowIdx = self.windowIdx
            
        return self
    
    def score_batch(self, X):
        X_normalized = (X - self.minimum)/(self.maximum - self.minimum)
        X_normalized[np.abs(X_normalized) == np.inf] = 0
        score_instance = 0
        for r in range(self.n_ensemble):
            ##### ------ n_ensemble branch ------ #####
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
                # get the scores
                c[row] = self.counts[r][row][hash_code]

            min_c = min(c)
            c = -np.log2(1+min_c)
            score_instance = score_instance + c

        ##### ------ COMMON ------ #####
        self.stream_score = score_instance /self.n_ensemble
        
        self.windowIdx_score_batch = self.windowIdx_score_batch + 1
        if self.windowIdx_score_batch>=self.batch_size:
            self.windowIdx_score_batch = 0
        else:
            self.windowIdx_score_batch = self.windowIdx_score_batch
            
        return self
    
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
    
    def fit_stream_continus(self, X):
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
        self.stream_score_norm = (score_instance/self.n_ensemble - self.bottom) / (self.peak - self.bottom)
        
        return self
        
    def score_stream(self):
        return self.stream_score
    
    def score_stream_norm(self):
        return self.stream_score_norm
    
    def hash_fun(self, s, k):
        hash_value = int(mmh3.hash(s, signed=False, seed=k))% self.matrix_col
        return hash_value
        
    def _process_decision_scores(self, scores):
        self.threshold = percentile(scores, 100* (1-self.contamination))
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
    n_ensemble      = 175
    batch_size      = 128
    num_hash = 2
    matrix_col = 128
    print("n_ensemble = ",n_ensemble)
    print("batch_size = ",batch_size)
    print("num_hash = ",num_hash)
    print("matrix_col = ",matrix_col)
    
    print("#=========================  real data  =========================#")
    data = Data("data")
    input_data = "{data_name}.mat".format(data_name=data_name)
    X_train, y_train = data.get_data(input_data)  # Load data.
    X_train, y_train = shuffle(X_train, y_train, random_state=67)  # Shuffle data.
    
    if save_en != '0':
        data_hls_path = "./../fpga/data_hls/rshash/"
        save_X_name = "{data_name}_X".format(data_name=data_name)
        save_y_name = "{data_name}_y".format(data_name=data_name)
        np.savetxt(data_hls_path + save_X_name, X_train, delimiter=',')
        np.savetxt(data_hls_path + save_y_name, y_train, delimiter=',')
        
        data_gcc_path = "./../gcc/data_gcc/rshash/"
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

    model = rshash(n_ensemble      = n_ensemble,
                  batch_size       = batch_size,
                  num_hash         = num_hash,
                  matrix_col       = matrix_col,
                  contamination    = contamination, 
                  feature_dim      = n_features,
                  data_num         = X_train.shape[0],
                  sampling_points  = sampling_points,
                  data_name        = data_name,
                  save_en          = save_en)

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
        data_path = "scores/rshash/"
        save_score_name = "score_{data_name}".format(data_name=data_name)
        np.savetxt(data_path + save_score_name, model_scores, delimiter=',')
    
    
