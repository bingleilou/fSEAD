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

optParser = OptionParser()
optParser.add_option('--ad', action='store',type='string',dest='ad', default = 'loda',help='ad')
optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
(options, args) = optParser.parse_args()
detector = options.ad
data_name = options.data_name

BATCH_SIZE = 128

print('ad = ',detector, 'data_name = ',data_name)
y_benchmark_path="./../data_gcc/{data_name}_y".format(ad=detector, data_name=data_name)
y_benchmark   = np.loadtxt(y_benchmark_path)
y_benchmark = np.array(y_benchmark).ravel()
contamination = y_benchmark.sum() / len(y_benchmark)

score_path="./_results/{ad}_{data_name}_score".format(ad=detector, data_name=data_name)
score  = np.loadtxt(score_path)
score = np.array(score).ravel()
threshold = percentile(score, 100* (1-contamination))
label = (score >= threshold).astype('int').ravel()

auroc_score = roc_auc_score(y_benchmark[BATCH_SIZE:], score[BATCH_SIZE:])
auroc_label = roc_auc_score(y_benchmark[BATCH_SIZE:], label[BATCH_SIZE:])
print("auroc_score = ",auroc_score)
print("auroc_label = ",auroc_label)
print(" ")


