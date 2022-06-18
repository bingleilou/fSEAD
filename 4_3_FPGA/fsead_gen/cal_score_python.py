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
optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
(options, args) = optParser.parse_args()

data_name = options.data_name
detector = options.ad

BATCH_SIZE = 128

print("detector = ",detector)
print("data_name = ",data_name)

y_benchmark_path="./data_c/4.18/{ad}/{data_name}_y".format(ad=detector, data_name=data_name)
y_benchmark   = np.loadtxt(y_benchmark_path)
y_benchmark = np.array(y_benchmark).ravel()
contamination = y_benchmark.sum() / len(y_benchmark)

print("y.shape = ",y_benchmark.shape)


score_path="./scores/4.18/{ad}/score_{data_name}".format(ad=detector, data_name=data_name)
score  = np.loadtxt(score_path)
score = np.array(score).ravel()
threshold = percentile(score, 100* (1-contamination))
label = (score > threshold).astype('int').ravel()

auroc_score = roc_auc_score(y_benchmark[BATCH_SIZE:], score[BATCH_SIZE:])
auroc_label = roc_auc_score(y_benchmark[BATCH_SIZE:], label[BATCH_SIZE:])
print('auc-score = ', auroc_score)
print('auc-label = ', auroc_label)


















