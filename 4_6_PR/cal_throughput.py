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



time_loda     = [3.4623, 3.5472, 3.6392, 3.7296]
time_rshash   = [3.7127, 3.8111, 3.8915, 3.9200]
time_xstream  = [3.8157, 3.8426, 3.8950, 3.9370]

throughput_loda     = [1831*1692000/3.4623/10e9, 1831*3196000/3.5472/10e9, 1831*4888000/3.6392/10e9, 1831*6580000/3.7296/10e9]
throughput_rshash   = [1831*7944000/3.7127/10e9, 1831*17212000/3.8111/10e9, 1831*25156000/3.8915/10e9, 1831*33100000/3.9200/10e9]
throughput_xstream  = [1831*13020000/3.8157/10e9, 1831*26040000/3.8426/10e9, 1831*39060000/3.8950/10e9, 1831*52080000/3.9370/10e9]


E_resource = [20, 40, 60, 80]
####################################################################################################
##
## plot
##
####################################################################################################
from matplotlib.ticker import FuncFormatter
plt.rcParams['font.family'] = ['Times New Roman']
plt.rcParams.update({'font.size': 8}) 
x = range(11)
y = range(11)
plt.plot(x, y)
 
def to_percent(temp, position):
  return '%1.0f'%(1*temp) + '%' 


fig = plt.figure(figsize=(6.5,4)) #18,5

plt.plot(E_resource, (time_loda), label = 'Loda')
plt.scatter(E_resource, (time_loda), color='black', marker='x', alpha=1, s=50)

plt.plot(E_resource, (time_rshash), label = 'RS-Hash')
plt.scatter(E_resource, (time_rshash), color='black', marker='x', alpha=1, s=50)

plt.plot(E_resource, (time_xstream), label = 'xStream')
plt.scatter(E_resource, (time_xstream), color='black', marker='x', alpha=1, s=50)

plt.gca().xaxis.set_major_formatter(FuncFormatter(to_percent))

plt.xlim(10,90)
plt.ylim(3.3,4.2)
plt.xlabel('Resource Utilization of RP-4')
plt.ylabel('Execution Time')
plt.legend()
plt.tight_layout()
plt.savefig('./figures/Time_5.28.eps', dpi=600, format='eps')




fig = plt.figure(figsize=(4,2.7)) #18,5
plt.grid()
plt.plot(E_resource, (throughput_loda), label = 'Loda', zorder=2)
plt.scatter(E_resource, (throughput_loda), color='black', marker='x', alpha=1, s=30, zorder=3)

plt.plot(E_resource, (throughput_rshash), label = 'RS-Hash', zorder=2)
plt.scatter(E_resource, (throughput_rshash), color='black', marker='x', alpha=1, s=30, zorder=3)

plt.plot(E_resource, (throughput_xstream), label = 'xStream', zorder=2)
plt.scatter(E_resource, (throughput_xstream), color='black', marker='x', alpha=1, s=30, zorder=3)

plt.gca().xaxis.set_major_formatter(FuncFormatter(to_percent))

plt.xlim(10,90)
#plt.ylim(3.3,4.2)
plt.xlabel('Resource Utilization')
plt.ylabel('Throughput (GOPs)')
plt.legend()

plt.tight_layout()
plt.savefig('./figures/Throughput_5.28.eps', dpi=600, format='eps')

