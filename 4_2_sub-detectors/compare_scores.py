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

optParser = OptionParser()
optParser.add_option('--ad', action='store',type='string',dest='ad', default = 'loda',help='ad')
(options, args) = optParser.parse_args()
detector = options.ad

BATCH_SIZE = 128
E_list = [4,5,6,7,8,9,10,20,40,60,80,100,120,140,160,180,200]
run_num = 10

print("detector = ",detector)

auc_score_E_cardio    = np.zeros((len(E_list), run_num))
auc_label_E_cardio    = np.zeros((len(E_list), run_num))
auc_score_mean_cardio    = np.zeros(len(E_list))
auc_score_var_cardio    = np.zeros(len(E_list))
auc_label_mean_cardio    = np.zeros(len(E_list))
auc_label_var_cardio    = np.zeros(len(E_list))
aucs_print_cardio = []
aucsvar_print_cardio = []
aucl_print_cardio = []
auclvar_print_cardio = []

auc_score_E_shuttle    = np.zeros((len(E_list), run_num))
auc_label_E_shuttle    = np.zeros((len(E_list), run_num))
auc_score_mean_shuttle    = np.zeros(len(E_list))
auc_score_var_shuttle    = np.zeros(len(E_list))
auc_label_mean_shuttle    = np.zeros(len(E_list))
auc_label_var_shuttle    = np.zeros(len(E_list))
aucs_print_shuttle = []
aucsvar_print_shuttle = []
aucl_print_shuttle = []
auclvar_print_shuttle = []

auc_score_E_smtp1    = np.zeros((len(E_list), run_num))
auc_label_E_smtp1    = np.zeros((len(E_list), run_num))
auc_score_mean_smtp1    = np.zeros(len(E_list))
auc_score_var_smtp1    = np.zeros(len(E_list))
auc_label_mean_smtp1    = np.zeros(len(E_list))
auc_label_var_smtp1    = np.zeros(len(E_list))
aucs_print_smtp1 = []
aucsvar_print_smtp1 = []
aucl_print_smtp1 = []
auclvar_print_smtp1 = []

auc_score_E_http1    = np.zeros((len(E_list), run_num))
auc_label_E_http1    = np.zeros((len(E_list), run_num))
auc_score_mean_http1    = np.zeros(len(E_list))
auc_score_var_http1    = np.zeros(len(E_list))
auc_label_mean_http1    = np.zeros(len(E_list))
auc_label_var_http1    = np.zeros(len(E_list))
aucs_print_http1 = []
aucsvar_print_http1 = []
aucl_print_http1 = []
auclvar_print_http1 = []

for i in tqdm(range(len(E_list)), desc='E_list...'):
    index = E_list[i]
    for m in range(run_num):
        y_benchmark_path_cardio="./gcc/data_gcc/{data_name}_y".format(ad=detector, data_name='cardio')
        y_benchmark_cardio   = np.loadtxt(y_benchmark_path_cardio)
        y_benchmark_cardio = np.array(y_benchmark_cardio).ravel()
        score_path_cardio="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad=detector, data_name='cardio',e=index,m=m+1)
        score_cardio  = np.loadtxt(score_path_cardio)
        score_cardio = np.array(score_cardio).ravel()
        auroc_score_cardio = roc_auc_score(y_benchmark_cardio[BATCH_SIZE:], score_cardio[BATCH_SIZE:])
        auc_score_E_cardio[i][m] = auroc_score_cardio
        
        y_benchmark_path_shuttle="./gcc/data_gcc/{data_name}_y".format(ad=detector, data_name='shuttle')
        y_benchmark_shuttle   = np.loadtxt(y_benchmark_path_shuttle)
        y_benchmark_shuttle = np.array(y_benchmark_shuttle).ravel()
        score_path_shuttle="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad=detector, data_name='shuttle',e=index,m=m+1)
        score_shuttle  = np.loadtxt(score_path_shuttle)
        score_shuttle = np.array(score_shuttle).ravel()
        auroc_score_shuttle = roc_auc_score(y_benchmark_shuttle[BATCH_SIZE:], score_shuttle[BATCH_SIZE:])
        auc_score_E_shuttle[i][m] = auroc_score_shuttle
        
        y_benchmark_path_smtp1="./gcc/data_gcc/{data_name}_y".format(ad=detector, data_name='smtp1')
        y_benchmark_smtp1   = np.loadtxt(y_benchmark_path_smtp1)
        y_benchmark_smtp1 = np.array(y_benchmark_smtp1).ravel()
        score_path_smtp1="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad=detector, data_name='smtp1',e=index,m=m+1)
        score_smtp1  = np.loadtxt(score_path_smtp1)
        score_smtp1 = np.array(score_smtp1).ravel()
        auroc_score_smtp1 = roc_auc_score(y_benchmark_smtp1[BATCH_SIZE:], score_smtp1[BATCH_SIZE:])
        auc_score_E_smtp1[i][m] = auroc_score_smtp1
        
        y_benchmark_path_http1="./gcc/data_gcc/{data_name}_y".format(ad=detector, data_name='http1')
        y_benchmark_http1   = np.loadtxt(y_benchmark_path_http1)
        y_benchmark_http1 = np.array(y_benchmark_http1).ravel()
        score_path_http1="./gcc/{ad}/{data_name}/E{e}/M{m}/scores".format(ad=detector, data_name='http1',e=index,m=m+1)
        score_http1  = np.loadtxt(score_path_http1)
        score_http1 = np.array(score_http1).ravel()
        auroc_score_http1 = roc_auc_score(y_benchmark_http1[BATCH_SIZE:], score_http1[BATCH_SIZE:])
        auc_score_E_http1[i][m] = auroc_score_http1
                             
    auc_score_mean_cardio[i] = np.sum(auc_score_E_cardio[i][:])/run_num
    auc_score_var_cardio[i]  = np.var(auc_score_E_cardio[i][:])
    AUCS_cardio = auc_score_mean_cardio[i]
    AUCSvar_cardio = auc_score_var_cardio[i]
    aucs_print_cardio.append(AUCS_cardio)
    aucsvar_print_cardio.append(AUCSvar_cardio)
    
    auc_score_mean_shuttle[i] = np.sum(auc_score_E_shuttle[i][:])/run_num
    auc_score_var_shuttle[i]  = np.var(auc_score_E_shuttle[i][:])
    AUCS_shuttle = auc_score_mean_shuttle[i]
    AUCSvar_shuttle = auc_score_var_shuttle[i]
    aucs_print_shuttle.append(AUCS_shuttle)
    aucsvar_print_shuttle.append(AUCSvar_shuttle)
    
    auc_score_mean_smtp1[i] = np.sum(auc_score_E_smtp1[i][:])/run_num
    auc_score_var_smtp1[i]  = np.var(auc_score_E_smtp1[i][:])
    AUCS_smtp1 = auc_score_mean_smtp1[i]
    AUCSvar_smtp1 = auc_score_var_smtp1[i]
    aucs_print_smtp1.append(AUCS_smtp1)
    aucsvar_print_smtp1.append(AUCSvar_smtp1)
    
    auc_score_mean_http1[i] = np.sum(auc_score_E_http1[i][:])/run_num
    auc_score_var_http1[i]  = np.var(auc_score_E_http1[i][:])
    AUCS_http1 = auc_score_mean_http1[i]
    AUCSvar_http1 = auc_score_var_http1[i]
    aucs_print_http1.append(AUCS_http1)
    aucsvar_print_http1.append(AUCSvar_http1)
print("==========================================\n")


####################################################################################################
##
## plot
##
####################################################################################################
fig = plt.figure(figsize=(12,4)) #18,5
plt.suptitle("Detector: {ad}".format(ad=detector),fontsize=11)

fig.add_subplot(241)
plt.plot(E_list, (aucs_print_cardio), color='orangered')
plt.scatter(E_list, (aucs_print_cardio), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(a) AUC on Cardio')

fig.add_subplot(242)
plt.plot(E_list, (aucs_print_shuttle), color='orangered')
plt.scatter(E_list, (aucs_print_shuttle), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(b) AUC on Shuttle')

fig.add_subplot(243)
plt.plot(E_list, (aucs_print_smtp1), color='orangered')
plt.scatter(E_list, (aucs_print_smtp1), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(c) AUC on SMTP-3')

fig.add_subplot(244)
plt.plot(E_list, (aucs_print_http1), color='orangered')
plt.scatter(E_list, (aucs_print_http1), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(d) AUC on HTTP-3')
plt.tight_layout()

fig.add_subplot(245)
plt.plot(E_list, (aucsvar_print_cardio), color='green')
plt.scatter(E_list, (aucsvar_print_cardio), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(e) Variance of AUC on Cardio')

fig.add_subplot(246)
plt.plot(E_list, (aucsvar_print_shuttle), color='green')
plt.scatter(E_list, (aucsvar_print_shuttle), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(f) Variance of AUC on Shuttle')

fig.add_subplot(247)
plt.plot(E_list, (aucsvar_print_smtp1), color='green')
plt.scatter(E_list, (aucsvar_print_smtp1), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(g) Variance of AUC on SMTP-3')

fig.add_subplot(248)
plt.plot(E_list, (aucsvar_print_http1), color='green')
plt.scatter(E_list, (aucsvar_print_http1), color='black', marker='.', alpha=1, s=50)
plt.xlabel('(h) Variance of AUC on HTTP-3')
plt.tight_layout()

plt.savefig('./figures/ACUS_{detector}.eps'.format(detector=detector), dpi=600, format='eps')


