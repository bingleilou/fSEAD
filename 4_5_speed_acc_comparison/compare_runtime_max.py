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
import re

optParser = OptionParser()
optParser.add_option('--ad', action='store',type='string',dest='ad', default = 'loda',help='ad')
(options, args) = optParser.parse_args()

detector = options.ad
print("detector = ",detector)


BATCH_SIZE = 128
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
    df_data=[]
    score_path="./../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/{ad}/{data_name}/runtime".format(ad=detector, data_name=data_name)
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
        cardio_mean_print = mean
    elif data_name == 'shuttle':
        shuttle_mean_print = mean
    elif data_name == 'smtp1':
        smtp1_mean_print = mean
    elif data_name == 'http1':
        http1_mean_print = mean


print('cardio_mean_print = ',cardio_mean_print)
print('shuttle_mean_print = ',shuttle_mean_print)
print('smtp1_mean_print = ',smtp1_mean_print)
print('http1_mean_print = ',http1_mean_print)