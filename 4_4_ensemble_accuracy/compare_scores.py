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
from optparse import OptionParser
from matplotlib.pyplot import figure, show
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
from matplotlib import cm, colors
from combo.models.score_comb import average as combo_average

optParser = OptionParser()
optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
(options, args) = optParser.parse_args()

data_name = options.data_name

BATCH_SIZE = 128
E_list_loda    = [35,70,105,140,175,210,245]
E_list_rshash  = [25,50,75,100,125,150,175]
E_list_xstream = [20,40,60,80,100,120,140]

E_list_combo223    = [2,2,3]
E_list_combo232    = [2,3,2]
E_list_combo322    = [3,2,2]
E_list_combo331    = [3,3,1]
E_list_combo313    = [3,1,3]
E_list_combo133    = [1,3,3]
run_num = 10

print("data_name = ",data_name)

y_loda_benchmark_path="./gcc/data_gcc/{data_name}_y".format(data_name=data_name)
y_loda_benchmark   = np.loadtxt(y_loda_benchmark_path)
y_loda_benchmark = np.array(y_loda_benchmark).ravel()
contamination_loda = y_loda_benchmark.sum() / len(y_loda_benchmark)

y_rshash_benchmark_path="./gcc/data_gcc/{data_name}_y".format(data_name=data_name)
y_rshash_benchmark   = np.loadtxt(y_rshash_benchmark_path)
y_rshash_benchmark = np.array(y_rshash_benchmark).ravel()
contamination_rshash = y_rshash_benchmark.sum() / len(y_rshash_benchmark)

y_xstream_benchmark_path="./gcc/data_gcc/{data_name}_y".format(data_name=data_name)
y_xstream_benchmark   = np.loadtxt(y_xstream_benchmark_path)
y_xstream_benchmark = np.array(y_xstream_benchmark).ravel()
contamination_xstream = y_xstream_benchmark.sum() / len(y_xstream_benchmark)

print("y.shape = ",y_loda_benchmark.shape)
auc_score_E_loda    = np.zeros(run_num)
auc_label_E_loda    = np.zeros(run_num)
auc_score_E_rshash  = np.zeros(run_num)
auc_label_E_rshash  = np.zeros(run_num)
auc_score_E_xstream = np.zeros(run_num)
auc_label_E_xstream = np.zeros(run_num)
auc_score_E_combo223  = np.zeros(run_num)
auc_label_E_combo223  = np.zeros(run_num)
auc_score_E_combo232  = np.zeros(run_num)
auc_label_E_combo232  = np.zeros(run_num)
auc_score_E_combo322  = np.zeros(run_num)
auc_label_E_combo322  = np.zeros(run_num)
auc_score_E_combo331  = np.zeros(run_num)
auc_label_E_combo331  = np.zeros(run_num)
auc_score_E_combo313  = np.zeros(run_num)
auc_label_E_combo313  = np.zeros(run_num)
auc_score_E_combo133  = np.zeros(run_num)
auc_label_E_combo133  = np.zeros(run_num)

aucs_print = []
aucsvar_print = []
aucl_print = []
auclvar_print = []


for m in range(run_num):
    ##############################################################################
    ########################        single detector       ########################
    ##############################################################################
    index_loda    = E_list_loda[6]
    index_rshash  = E_list_rshash[6]
    index_xstream = E_list_xstream[6]
    score_path_loda="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='loda', data_name=data_name,e=index_loda,m=m+1)
    score_path_rshash="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='rshash', data_name=data_name,e=index_rshash,m=m+1)
    score_path_xstream="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='xstream', data_name=data_name,e=index_xstream,m=m+1)
    
    score_loda  = np.loadtxt(score_path_loda)
    score_loda = np.array(score_loda).ravel()
    threshold_loda = percentile(score_loda, 100* (1-contamination_loda))
    label_loda = (score_loda > threshold_loda).astype('int').ravel()

    score_rshash  = np.loadtxt(score_path_rshash)
    score_rshash = np.array(score_rshash).ravel()
    threshold_rshash = percentile(score_rshash, 100* (1-contamination_rshash))
    label_rshash = (score_rshash > threshold_rshash).astype('int').ravel()

    score_xstream  = np.loadtxt(score_path_xstream)
    score_xstream = np.array(score_xstream).ravel()
    threshold_xstream = percentile(score_xstream, 100* (1-contamination_xstream))
    label_xstream = (score_xstream > threshold_xstream).astype('int').ravel()
    
    auroc_score_loda = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_loda[BATCH_SIZE:])
    auroc_label_loda = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_loda[BATCH_SIZE:])
    auroc_score_rshash = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_rshash[BATCH_SIZE:])
    auroc_label_rshash = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_rshash[BATCH_SIZE:])
    auroc_score_xstream = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_xstream[BATCH_SIZE:])
    auroc_label_xstream = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_xstream[BATCH_SIZE:])

    auc_score_E_loda[m] = auroc_score_loda
    auc_label_E_loda[m] = auroc_label_loda
    auc_score_E_rshash[m] = auroc_score_rshash
    auc_label_E_rshash[m] = auroc_label_rshash
    auc_score_E_xstream[m] = auroc_score_xstream
    auc_label_E_xstream[m] = auroc_label_xstream
    
    ##############################################################################
    ########################           combo223           ########################
    ##############################################################################
    index_loda    = E_list_loda[E_list_combo223[0]]
    index_rshash  = E_list_rshash[E_list_combo223[1]]
    index_xstream = E_list_xstream[E_list_combo223[2]]
    score_path_loda="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='loda', data_name=data_name,e=index_loda,m=m+1)
    score_path_rshash="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='rshash', data_name=data_name,e=index_rshash,m=m+1)
    score_path_xstream="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='xstream', data_name=data_name,e=index_xstream,m=m+1)
    
    score_loda  = np.loadtxt(score_path_loda)
    score_loda = np.array(score_loda).ravel()
    threshold_loda = percentile(score_loda, 100* (1-contamination_loda))
    label_loda = (score_loda > threshold_loda).astype('int').ravel()

    score_rshash  = np.loadtxt(score_path_rshash)
    score_rshash = np.array(score_rshash).ravel()
    threshold_rshash = percentile(score_rshash, 100* (1-contamination_rshash))
    label_rshash = (score_rshash > threshold_rshash).astype('int').ravel()

    score_xstream  = np.loadtxt(score_path_xstream)
    score_xstream = np.array(score_xstream).ravel()
    threshold_xstream = percentile(score_xstream, 100* (1-contamination_xstream))
    label_xstream = (score_xstream > threshold_xstream).astype('int').ravel()

    # Concatenate of stream scores
    score_loda_norm = np.reshape(score_loda, (len(score_loda),1))
    score_rshash_norm = np.reshape(score_rshash, (len(score_rshash),1))
    score_xstream_norm = np.reshape(score_xstream, (len(score_xstream),1))
    score_12_norm = np.concatenate((score_loda_norm, score_rshash_norm),axis=1)
    score_123_norm = np.concatenate((score_12_norm, score_xstream_norm),axis=1)
    score_combo223  = combo_average(score_123_norm)
    
    # Concatenate of stream labels
    label_loda_norm = np.reshape(label_loda, (len(label_loda),1))
    label_rshash_norm = np.reshape(label_rshash, (len(label_rshash),1))
    label_xstream_norm = np.reshape(label_xstream, (len(label_xstream),1))
    label_12_norm = np.concatenate((label_loda_norm, label_rshash_norm),axis=1)
    label_123_norm = np.concatenate((label_12_norm, label_xstream_norm),axis=1)
    vote_label_norm_list = []
    for i in range(label_123_norm.shape[0]):
        if label_123_norm[i][0]==0 and label_123_norm[i][1]==0 and label_123_norm[i][2]==0:
            label_combo_i = 0
        else:
            label_combo_i = 1
        vote_label_norm_list.append(label_combo_i)
    label_combo223 = np.array(vote_label_norm_list)
    
    auroc_score_combo223 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_combo223[BATCH_SIZE:])
    auroc_label_combo223 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_combo223[BATCH_SIZE:])

    auc_score_E_combo223[m] = auroc_score_combo223
    auc_label_E_combo223[m] = auroc_label_combo223
    
    ##############################################################################
    ########################           combo232           ########################
    ##############################################################################
    index_loda    = E_list_loda[E_list_combo232[0]]
    index_rshash  = E_list_rshash[E_list_combo232[1]]
    index_xstream = E_list_xstream[E_list_combo232[2]]
    score_path_loda="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='loda', data_name=data_name,e=index_loda,m=m+1)
    score_path_rshash="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='rshash', data_name=data_name,e=index_rshash,m=m+1)
    score_path_xstream="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='xstream', data_name=data_name,e=index_xstream,m=m+1)
    
    score_loda  = np.loadtxt(score_path_loda)
    score_loda = np.array(score_loda).ravel()
    threshold_loda = percentile(score_loda, 100* (1-contamination_loda))
    label_loda = (score_loda > threshold_loda).astype('int').ravel()

    score_rshash  = np.loadtxt(score_path_rshash)
    score_rshash = np.array(score_rshash).ravel()
    threshold_rshash = percentile(score_rshash, 100* (1-contamination_rshash))
    label_rshash = (score_rshash > threshold_rshash).astype('int').ravel()

    score_xstream  = np.loadtxt(score_path_xstream)
    score_xstream = np.array(score_xstream).ravel()
    threshold_xstream = percentile(score_xstream, 100* (1-contamination_xstream))
    label_xstream = (score_xstream > threshold_xstream).astype('int').ravel()

    # Concatenate of stream scores
    score_loda_norm = np.reshape(score_loda, (len(score_loda),1))
    score_rshash_norm = np.reshape(score_rshash, (len(score_rshash),1))
    score_xstream_norm = np.reshape(score_xstream, (len(score_xstream),1))
    score_12_norm = np.concatenate((score_loda_norm, score_rshash_norm),axis=1)
    score_123_norm = np.concatenate((score_12_norm, score_xstream_norm),axis=1)
    score_combo232  = combo_average(score_123_norm)
    
    # Concatenate of stream labels
    label_loda_norm = np.reshape(label_loda, (len(label_loda),1))
    label_rshash_norm = np.reshape(label_rshash, (len(label_rshash),1))
    label_xstream_norm = np.reshape(label_xstream, (len(label_xstream),1))
    label_12_norm = np.concatenate((label_loda_norm, label_rshash_norm),axis=1)
    label_123_norm = np.concatenate((label_12_norm, label_xstream_norm),axis=1)
    vote_label_norm_list = []
    for i in range(label_123_norm.shape[0]):
        if label_123_norm[i][0]==0 and label_123_norm[i][1]==0 and label_123_norm[i][2]==0:
            label_combo_i = 0
        else:
            label_combo_i = 1
        vote_label_norm_list.append(label_combo_i)
    label_combo232 = np.array(vote_label_norm_list)
    
    auroc_score_combo232 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_combo232[BATCH_SIZE:])
    auroc_label_combo232 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_combo232[BATCH_SIZE:])

    auc_score_E_combo232[m] = auroc_score_combo232
    auc_label_E_combo232[m] = auroc_label_combo232

    ##############################################################################
    ########################           combo322           ########################
    ##############################################################################
    index_loda    = E_list_loda[E_list_combo322[0]]
    index_rshash  = E_list_rshash[E_list_combo322[1]]
    index_xstream = E_list_xstream[E_list_combo322[2]]
    score_path_loda="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='loda', data_name=data_name,e=index_loda,m=m+1)
    score_path_rshash="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='rshash', data_name=data_name,e=index_rshash,m=m+1)
    score_path_xstream="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='xstream', data_name=data_name,e=index_xstream,m=m+1)
    
    score_loda  = np.loadtxt(score_path_loda)
    score_loda = np.array(score_loda).ravel()
    threshold_loda = percentile(score_loda, 100* (1-contamination_loda))
    label_loda = (score_loda > threshold_loda).astype('int').ravel()

    score_rshash  = np.loadtxt(score_path_rshash)
    score_rshash = np.array(score_rshash).ravel()
    threshold_rshash = percentile(score_rshash, 100* (1-contamination_rshash))
    label_rshash = (score_rshash > threshold_rshash).astype('int').ravel()

    score_xstream  = np.loadtxt(score_path_xstream)
    score_xstream = np.array(score_xstream).ravel()
    threshold_xstream = percentile(score_xstream, 100* (1-contamination_xstream))
    label_xstream = (score_xstream > threshold_xstream).astype('int').ravel()

    # Concatenate of stream scores
    score_loda_norm = np.reshape(score_loda, (len(score_loda),1))
    score_rshash_norm = np.reshape(score_rshash, (len(score_rshash),1))
    score_xstream_norm = np.reshape(score_xstream, (len(score_xstream),1))
    score_12_norm = np.concatenate((score_loda_norm, score_rshash_norm),axis=1)
    score_123_norm = np.concatenate((score_12_norm, score_xstream_norm),axis=1)
    score_combo322  = combo_average(score_123_norm)
    
    # Concatenate of stream labels
    label_loda_norm = np.reshape(label_loda, (len(label_loda),1))
    label_rshash_norm = np.reshape(label_rshash, (len(label_rshash),1))
    label_xstream_norm = np.reshape(label_xstream, (len(label_xstream),1))
    label_12_norm = np.concatenate((label_loda_norm, label_rshash_norm),axis=1)
    label_123_norm = np.concatenate((label_12_norm, label_xstream_norm),axis=1)
    vote_label_norm_list = []
    for i in range(label_123_norm.shape[0]):
        if label_123_norm[i][0]==0 and label_123_norm[i][1]==0 and label_123_norm[i][2]==0:
            label_combo_i = 0
        else:
            label_combo_i = 1
        vote_label_norm_list.append(label_combo_i)
    label_combo322 = np.array(vote_label_norm_list)
    
    auroc_score_combo322 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_combo322[BATCH_SIZE:])
    auroc_label_combo322 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_combo322[BATCH_SIZE:])

    auc_score_E_combo322[m] = auroc_score_combo322
    auc_label_E_combo322[m] = auroc_label_combo322
    
    ##############################################################################
    ########################           combo331           ########################
    ##############################################################################
    index_loda    = E_list_loda[E_list_combo331[0]]
    index_rshash  = E_list_rshash[E_list_combo331[1]]
    index_xstream = E_list_xstream[E_list_combo331[2]]
    score_path_loda="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='loda', data_name=data_name,e=index_loda,m=m+1)
    score_path_rshash="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='rshash', data_name=data_name,e=index_rshash,m=m+1)
    score_path_xstream="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='xstream', data_name=data_name,e=index_xstream,m=m+1)
    
    score_loda  = np.loadtxt(score_path_loda)
    score_loda = np.array(score_loda).ravel()
    threshold_loda = percentile(score_loda, 100* (1-contamination_loda))
    label_loda = (score_loda > threshold_loda).astype('int').ravel()

    score_rshash  = np.loadtxt(score_path_rshash)
    score_rshash = np.array(score_rshash).ravel()
    threshold_rshash = percentile(score_rshash, 100* (1-contamination_rshash))
    label_rshash = (score_rshash > threshold_rshash).astype('int').ravel()

    score_xstream  = np.loadtxt(score_path_xstream)
    score_xstream = np.array(score_xstream).ravel()
    threshold_xstream = percentile(score_xstream, 100* (1-contamination_xstream))
    label_xstream = (score_xstream > threshold_xstream).astype('int').ravel()

    # Concatenate of stream scores
    score_loda_norm = np.reshape(score_loda, (len(score_loda),1))
    score_rshash_norm = np.reshape(score_rshash, (len(score_rshash),1))
    score_xstream_norm = np.reshape(score_xstream, (len(score_xstream),1))
    score_12_norm = np.concatenate((score_loda_norm, score_rshash_norm),axis=1)
    score_123_norm = np.concatenate((score_12_norm, score_xstream_norm),axis=1)
    score_combo331  = combo_average(score_123_norm)
    
    # Concatenate of stream labels
    label_loda_norm = np.reshape(label_loda, (len(label_loda),1))
    label_rshash_norm = np.reshape(label_rshash, (len(label_rshash),1))
    label_xstream_norm = np.reshape(label_xstream, (len(label_xstream),1))
    label_12_norm = np.concatenate((label_loda_norm, label_rshash_norm),axis=1)
    label_123_norm = np.concatenate((label_12_norm, label_xstream_norm),axis=1)
    vote_label_norm_list = []
    for i in range(label_123_norm.shape[0]):
        if label_123_norm[i][0]==0 and label_123_norm[i][1]==0 and label_123_norm[i][2]==0:
            label_combo_i = 0
        else:
            label_combo_i = 1
        vote_label_norm_list.append(label_combo_i)
    label_combo331 = np.array(vote_label_norm_list)
    
    auroc_score_combo331 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_combo331[BATCH_SIZE:])
    auroc_label_combo331 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_combo331[BATCH_SIZE:])

    auc_score_E_combo331[m] = auroc_score_combo331
    auc_label_E_combo331[m] = auroc_label_combo331
    
    ##############################################################################
    ########################           combo313           ########################
    ##############################################################################
    index_loda    = E_list_loda[E_list_combo313[0]]
    index_rshash  = E_list_rshash[E_list_combo313[1]]
    index_xstream = E_list_xstream[E_list_combo313[2]]
    score_path_loda="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='loda', data_name=data_name,e=index_loda,m=m+1)
    score_path_rshash="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='rshash', data_name=data_name,e=index_rshash,m=m+1)
    score_path_xstream="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='xstream', data_name=data_name,e=index_xstream,m=m+1)
    
    score_loda  = np.loadtxt(score_path_loda)
    score_loda = np.array(score_loda).ravel()
    threshold_loda = percentile(score_loda, 100* (1-contamination_loda))
    label_loda = (score_loda > threshold_loda).astype('int').ravel()

    score_rshash  = np.loadtxt(score_path_rshash)
    score_rshash = np.array(score_rshash).ravel()
    threshold_rshash = percentile(score_rshash, 100* (1-contamination_rshash))
    label_rshash = (score_rshash > threshold_rshash).astype('int').ravel()

    score_xstream  = np.loadtxt(score_path_xstream)
    score_xstream = np.array(score_xstream).ravel()
    threshold_xstream = percentile(score_xstream, 100* (1-contamination_xstream))
    label_xstream = (score_xstream > threshold_xstream).astype('int').ravel()

    # Concatenate of stream scores
    score_loda_norm = np.reshape(score_loda, (len(score_loda),1))
    score_rshash_norm = np.reshape(score_rshash, (len(score_rshash),1))
    score_xstream_norm = np.reshape(score_xstream, (len(score_xstream),1))
    score_12_norm = np.concatenate((score_loda_norm, score_rshash_norm),axis=1)
    score_123_norm = np.concatenate((score_12_norm, score_xstream_norm),axis=1)
    score_combo313  = combo_average(score_123_norm)
    
    # Concatenate of stream labels
    label_loda_norm = np.reshape(label_loda, (len(label_loda),1))
    label_rshash_norm = np.reshape(label_rshash, (len(label_rshash),1))
    label_xstream_norm = np.reshape(label_xstream, (len(label_xstream),1))
    label_12_norm = np.concatenate((label_loda_norm, label_rshash_norm),axis=1)
    label_123_norm = np.concatenate((label_12_norm, label_xstream_norm),axis=1)
    vote_label_norm_list = []
    for i in range(label_123_norm.shape[0]):
        if label_123_norm[i][0]==0 and label_123_norm[i][1]==0 and label_123_norm[i][2]==0:
            label_combo_i = 0
        else:
            label_combo_i = 1
        vote_label_norm_list.append(label_combo_i)
    label_combo313 = np.array(vote_label_norm_list)
    
    auroc_score_combo313 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_combo313[BATCH_SIZE:])
    auroc_label_combo313 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_combo313[BATCH_SIZE:])

    auc_score_E_combo313[m] = auroc_score_combo313
    auc_label_E_combo313[m] = auroc_label_combo313
    
    ##############################################################################
    ########################           combo133           ########################
    ##############################################################################
    index_loda    = E_list_loda[E_list_combo133[0]]
    index_rshash  = E_list_rshash[E_list_combo133[1]]
    index_xstream = E_list_xstream[E_list_combo133[2]]
    score_path_loda="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='loda', data_name=data_name,e=index_loda,m=m+1)
    score_path_rshash="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='rshash', data_name=data_name,e=index_rshash,m=m+1)
    score_path_xstream="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad='xstream', data_name=data_name,e=index_xstream,m=m+1)
    
    score_loda  = np.loadtxt(score_path_loda)
    score_loda = np.array(score_loda).ravel()
    threshold_loda = percentile(score_loda, 100* (1-contamination_loda))
    label_loda = (score_loda > threshold_loda).astype('int').ravel()

    score_rshash  = np.loadtxt(score_path_rshash)
    score_rshash = np.array(score_rshash).ravel()
    threshold_rshash = percentile(score_rshash, 100* (1-contamination_rshash))
    label_rshash = (score_rshash > threshold_rshash).astype('int').ravel()

    score_xstream  = np.loadtxt(score_path_xstream)
    score_xstream = np.array(score_xstream).ravel()
    threshold_xstream = percentile(score_xstream, 100* (1-contamination_xstream))
    label_xstream = (score_xstream > threshold_xstream).astype('int').ravel()

    # Concatenate of stream scores
    score_loda_norm = np.reshape(score_loda, (len(score_loda),1))
    score_rshash_norm = np.reshape(score_rshash, (len(score_rshash),1))
    score_xstream_norm = np.reshape(score_xstream, (len(score_xstream),1))
    score_12_norm = np.concatenate((score_loda_norm, score_rshash_norm),axis=1)
    score_123_norm = np.concatenate((score_12_norm, score_xstream_norm),axis=1)
    score_combo133  = combo_average(score_123_norm)
    
    # Concatenate of stream labels
    label_loda_norm = np.reshape(label_loda, (len(label_loda),1))
    label_rshash_norm = np.reshape(label_rshash, (len(label_rshash),1))
    label_xstream_norm = np.reshape(label_xstream, (len(label_xstream),1))
    label_12_norm = np.concatenate((label_loda_norm, label_rshash_norm),axis=1)
    label_123_norm = np.concatenate((label_12_norm, label_xstream_norm),axis=1)
    vote_label_norm_list = []
    for i in range(label_123_norm.shape[0]):
        if label_123_norm[i][0]==0 and label_123_norm[i][1]==0 and label_123_norm[i][2]==0:
            label_combo_i = 0
        else:
            label_combo_i = 1
        vote_label_norm_list.append(label_combo_i)
    label_combo133 = np.array(vote_label_norm_list)
    
    auroc_score_combo133 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], score_combo133[BATCH_SIZE:])
    auroc_label_combo133 = roc_auc_score(y_loda_benchmark[BATCH_SIZE:], label_combo133[BATCH_SIZE:])

    auc_score_E_combo133[m] = auroc_score_combo133
    auc_label_E_combo133[m] = auroc_label_combo133
    
auc_score_mean_loda = np.sum(auc_score_E_loda[:])/run_num
auc_score_var_loda  = np.var(auc_score_E_loda[:])
auc_label_mean_loda = np.sum(auc_label_E_loda[:])/run_num
auc_label_var_loda  = np.var(auc_label_E_loda[:])

auc_score_mean_rshash = np.sum(auc_score_E_rshash[:])/run_num
auc_score_var_rshash  = np.var(auc_score_E_rshash[:])
auc_label_mean_rshash = np.sum(auc_label_E_rshash[:])/run_num
auc_label_var_rshash  = np.var(auc_label_E_rshash[:])

auc_score_mean_xstream = np.sum(auc_score_E_xstream[:])/run_num
auc_score_var_xstream  = np.var(auc_score_E_xstream[:])
auc_label_mean_xstream = np.sum(auc_label_E_xstream[:])/run_num
auc_label_var_xstream  = np.var(auc_label_E_xstream[:])
    
auc_score_mean_combo223 = np.sum(auc_score_E_combo223[:])/run_num
auc_score_var_combo223  = np.var(auc_score_E_combo223[:])
auc_label_mean_combo223 = np.sum(auc_label_E_combo223[:])/run_num
auc_label_var_combo223  = np.var(auc_label_E_combo223[:])

auc_score_mean_combo232 = np.sum(auc_score_E_combo232[:])/run_num
auc_score_var_combo232  = np.var(auc_score_E_combo232[:])
auc_label_mean_combo232 = np.sum(auc_label_E_combo232[:])/run_num
auc_label_var_combo232  = np.var(auc_label_E_combo232[:])

auc_score_mean_combo322 = np.sum(auc_score_E_combo322[:])/run_num
auc_score_var_combo322  = np.var(auc_score_E_combo322[:])
auc_label_mean_combo322 = np.sum(auc_label_E_combo322[:])/run_num
auc_label_var_combo322  = np.var(auc_label_E_combo322[:])

auc_score_mean_combo331 = np.sum(auc_score_E_combo331[:])/run_num
auc_score_var_combo331  = np.var(auc_score_E_combo331[:])
auc_label_mean_combo331 = np.sum(auc_label_E_combo331[:])/run_num
auc_label_var_combo331  = np.var(auc_label_E_combo331[:])

auc_score_mean_combo313 = np.sum(auc_score_E_combo313[:])/run_num
auc_score_var_combo313  = np.var(auc_score_E_combo313[:])
auc_label_mean_combo313 = np.sum(auc_label_E_combo313[:])/run_num
auc_label_var_combo313  = np.var(auc_label_E_combo313[:])

auc_score_mean_combo133 = np.sum(auc_score_E_combo133[:])/run_num
auc_score_var_combo133  = np.var(auc_score_E_combo133[:])
auc_label_mean_combo133 = np.sum(auc_label_E_combo133[:])/run_num
auc_label_var_combo133  = np.var(auc_label_E_combo133[:])


print('AUCS-loda    = %f, AUCSvar-loda    = %f, ## AUCL-loda    = %f, AUCLvar-loda    = %f' % (auc_score_mean_loda, auc_score_var_loda, auc_label_mean_loda, auc_label_var_loda))
print('AUCS-rshash  = %f, AUCSvar-rshash  = %f, ## AUCL-rshash  = %f, AUCLvar-rshash  = %f' % (auc_score_mean_rshash, auc_score_var_rshash, auc_label_mean_rshash, auc_label_var_rshash))
print('AUCS-xstream = %f, AUCSvar-xstream = %f, ## AUCL-xstream = %f, AUCLvar-xstream = %f' % (auc_score_mean_xstream, auc_score_var_xstream, auc_label_mean_xstream, auc_label_var_xstream))
print('AUCS-comb223 = %f, AUCSvar-comb223 = %f, ## AUCL-comb223 = %f, AUCLvar-comb223 = %f' % (auc_score_mean_combo223, auc_score_var_combo223, auc_label_mean_combo223, auc_label_var_combo223))
print('AUCS-comb232 = %f, AUCSvar-comb232 = %f, ## AUCL-comb232 = %f, AUCLvar-comb232 = %f' % (auc_score_mean_combo232, auc_score_var_combo232, auc_label_mean_combo232, auc_label_var_combo232))
print('AUCS-comb322 = %f, AUCSvar-comb322 = %f, ## AUCL-comb322 = %f, AUCLvar-comb322 = %f' % (auc_score_mean_combo322, auc_score_var_combo322, auc_label_mean_combo322, auc_label_var_combo322))
print('AUCS-comb331 = %f, AUCSvar-comb331 = %f, ## AUCL-comb331 = %f, AUCLvar-comb331 = %f' % (auc_score_mean_combo331, auc_score_var_combo331, auc_label_mean_combo331, auc_label_var_combo331))
print('AUCS-comb313 = %f, AUCSvar-comb313 = %f, ## AUCL-comb313 = %f, AUCLvar-comb313 = %f' % (auc_score_mean_combo313, auc_score_var_combo313, auc_label_mean_combo313, auc_label_var_combo313))
print('AUCS-comb133 = %f, AUCSvar-comb133 = %f, ## AUCL-comb133 = %f, AUCLvar-comb133 = %f' % (auc_score_mean_combo133, auc_score_var_combo133, auc_label_mean_combo133, auc_label_var_combo133))

print("==========================================\n")

####################################################################################################
##
## plot
##
####################################################################################################
AUCS     = [auc_score_mean_loda,auc_score_mean_rshash,auc_score_mean_xstream,auc_score_mean_combo223,auc_score_mean_combo232,auc_score_mean_combo322,auc_score_mean_combo331,auc_score_mean_combo313,auc_score_mean_combo133]
AUCS_var = [auc_score_var_loda,auc_score_var_rshash,auc_score_var_xstream,auc_score_var_combo223,auc_score_var_combo232,auc_score_var_combo322,auc_score_var_combo331,auc_score_var_combo313,auc_score_var_combo133]
AUCL     = [auc_label_mean_loda, auc_label_mean_rshash, auc_label_mean_xstream, auc_label_mean_combo223,auc_label_mean_combo232,auc_label_mean_combo322,auc_label_mean_combo331,auc_label_mean_combo313,auc_label_mean_combo133]
AUCL_var = [auc_label_var_loda, auc_label_var_rshash, auc_label_var_xstream, auc_label_var_combo223,auc_label_var_combo232,auc_label_var_combo322,auc_label_var_combo331,auc_label_var_combo313,auc_label_var_combo133]


clf_name_score = data_name
fig = plt.figure(figsize=(9,5))

fig.add_subplot(221)
name_list = ['A7','B7','C7','c223','c232','c322','c331','c313','c133']
plt.bar(range(len(AUCS)), AUCS,tick_label=name_list, color=['gainsboro','silver','dimgrey','gold','gold','gold','gold','gold','gold'], width=0.5,edgecolor='black')
for x,y in zip(range(len(AUCS)), AUCS):
    plt.text(x,y, '%.3f'%y, size=6.0, ha='center', va='bottom')
plt.xlabel('(a) AUC Score')

fig.add_subplot(222)
name_list = ['A7','B7','C7','c223','c232','c322','c331','c313','c133']
plt.bar(range(len(AUCL)), AUCL,tick_label=name_list, color=['gainsboro','silver','dimgrey','coral','coral','coral','coral','coral','coral'], width=0.5,edgecolor='black')
for x,y in zip(range(len(AUCL)), AUCL):
    plt.text(x,y, '%.3f'%y, size=6.0, ha='center', va='bottom')
plt.xlabel('(b) AUC Label', size=12)

fig.add_subplot(223)
name_list = ['A7','B7','C7','c223','c232','c322','c331','c313','c133']
rects = plt.bar(range(len(AUCS_var)), AUCS_var,tick_label=name_list, color=['gainsboro','silver','dimgrey','gold','gold','gold','gold','gold','gold'], width=0.5,edgecolor='white')
for x,y in zip(range(len(AUCS_var)), AUCS_var):
    plt.text(x,y, '%.7f'%y, size=5.0, ha='center', va='bottom')
plt.xlabel('(c) Variance of AUC Score')

fig.add_subplot(224)
name_list = ['A7','B7','C7','c223','c232','c322','c331','c313','c133']
plt.bar(range(len(AUCL_var)), AUCL_var,tick_label=name_list, color=['gainsboro','silver','dimgrey','coral','coral','coral','coral','coral','coral'], width=0.5,edgecolor='white')
for x,y in zip(range(len(AUCL_var)), AUCL_var):
    plt.text(x,y, '%.5f'%y, size=5.5, ha='center', va='bottom')
plt.xlabel('(d) Variance of AUC Label')


plt.tight_layout()
plt.savefig('./figures/ACU_{clf_name_score}.eps'.format(clf_name_score=clf_name_score), dpi=600, format='eps')


