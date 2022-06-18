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
import re

optParser = OptionParser()
optParser.add_option('--ad', action='store',type='string',dest='ad', default = 'loda',help='ad')
(options, args) = optParser.parse_args()

detector = options.ad
print("detector = ",detector)


BATCH_SIZE = 128
E_list = [2,3,4,5,6,7,8,9,10,20,40,60,80,100,120,140,160,180,200]
data_list = ['cardio','shuttle','smtp1','http1']

cardio_mean_print = []
shuttle_mean_print = []
smtp1_mean_print = []
http1_mean_print = []
for k in range(len(data_list)):
    data_name = data_list[k]
    ##################################################################################
    ##
    ## 1. Read original x data file and generate the LIST: df_x
    ## 2. Read raw dpd data file and generate the LIST: df_data
    ##
    ##################################################################################
    re_data = re.compile('^(.*)\)(.*)')
    for i in range(len(E_list)):
        index = E_list[i]
        df_data=[]
        score_path="./gcc/{ad}/{data_name}/E{e}/runtime".format(ad=detector, data_name=data_name,e=index)
        with open(score_path ,"r" ,encoding="utf-8") as f_r:
            data_split_as_lines = f_r.read().splitlines()

        for i in range(len(data_split_as_lines)):
            result = re_data.search(data_split_as_lines[i])
            if result:
                d0 = result.group(2)
                df_data.append(int(d0))
        df_data = np.array(df_data)
        mean = np.mean(df_data)

        if data_name == 'cardio':
            cardio_mean_print.append(mean)
        elif data_name == 'shuttle':
            shuttle_mean_print.append(mean)
        elif data_name == 'smtp1':
            smtp1_mean_print.append(mean)
        elif data_name == 'http1':
            http1_mean_print.append(mean)
    print("==========================================\n")
    #print('mean_print = ',mean_print)

####################################################################################################
##
## plot
##
####################################################################################################

clf_name_score = detector

fig = plt.figure(1)
plt.suptitle(clf_name_score.format(clf_name_score=clf_name_score),fontsize=15)

fig.add_subplot(221)
plt.scatter(E_list, (cardio_mean_print), color='black', marker='.', alpha=1, s=50, label="cardio")
plt.xlabel('cardio')
plt.ylabel('ms')

fig.add_subplot(222)
name_list = E_list
plt.scatter(E_list, (shuttle_mean_print), color='black', marker='.', alpha=1, s=50, label="shuttle")
plt.xlabel('shuttle')
plt.ylabel('ms')

fig.add_subplot(223)
plt.scatter(E_list, (smtp1_mean_print), color='black', marker='.', alpha=1, s=50, label="smtp1")
plt.xlabel('smtp1')
plt.ylabel('ms')

fig.add_subplot(224)
name_list = E_list
plt.scatter(E_list, (http1_mean_print), color='black', marker='.', alpha=1, s=50, label="http1")
plt.xlabel('http1')
plt.ylabel('ms')
plt.tight_layout()

plt.savefig('./figures/Time_{detector}.png'.format(detector=detector))


