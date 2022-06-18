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
from matplotlib.legend_handler import HandlerTuple
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
        score_path="./../4_2_sub-detectors/gcc/{ad}/{data_name}/E{e}/runtime".format(ad=detector, data_name=data_name,e=index)
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

fpga_time_loda_cardio  = [3.74, 3.88, 3.99, 4.14, 4.28 ]
fpga_time_loda_shuttle = [33.34, 33.49, 33.63, 33.78, 33.95 ]
fpga_time_loda_smtp1   = [38.42, 38.58, 38.71, 38.85, 39.00 ]
fpga_time_loda_http1   = [227.35, 227.50, 227.66, 227.79, 227.96 ]

fpga_time_rshash_cardio  = [3.93, 4.05, 4.16, 4.38, 4.46, 4.62, 4.87,  8.8]
fpga_time_rshash_shuttle = [34.92, 35.06, 35.19, 35.43, 35.54, 35.66, 35.80,  70.72]
fpga_time_rshash_smtp1   = [38.44, 38.57, 38.72, 38.91, 39.00, 39.12, 39.32,  77.76]
fpga_time_rshash_http1   = [227.35, 227.48, 227.63, 227.82, 227.93, 228.29, 228.23,  455.58]

fpga_time_xstream_cardio  = [3.97, 4.07, 4.20, 4.35, 4.51, 4.68, 4.82,  8.79, 8.89, 9.06]
fpga_time_xstream_shuttle = [39.15, 39.24, 39.63, 40.07, 40.17, 40.35, 40.62,  79.77, 79.86, 80.25]
fpga_time_xstream_smtp1   = [50.07, 50.25, 50.37, 50.52, 50.67, 50.81, 50.99,  101.06, 101.24, 101.36]
fpga_time_xstream_http1   = [296.96, 297.10, 297.25, 297.41, 297.59, 297.71, 297.85,  594.81, 594.95, 595.1]

loda_x = [35,70,105,140,175]
rshash_x = [25,50,75,100,125,150,175,  200]
xstream_x = [20,40,60,80,100,120,140,  160,180,200]
####################################################################################################
##
## plot
##
####################################################################################################

fig = plt.figure(figsize=(15,2.15)) #10,2.15
#plt.suptitle("Detector: {ad}".format(ad=detector),fontsize=11)

ax=fig.add_subplot(141)
p1 = ax.scatter(E_list, (cardio_mean_print), color='orangered', marker='.', alpha=0.01, s=30, label="CPU")
ax.set_ylabel("CPU",size=9)
plt.xlabel('(a) Cardio')
if detector == 'loda':
    plt.ylim(0,50)
    ax1 = ax.twinx()
    p2 = ax1.scatter(loda_x[0:5], (fpga_time_loda_cardio[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,25.86)#(-5,50)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'rshash':
    plt.ylim(0,130)
    ax1 = ax.twinx()
    p2 = ax1.scatter(rshash_x[0:7], (fpga_time_rshash_cardio[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(rshash_x[7:], (fpga_time_rshash_cardio[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,25.98)#(-13,130)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'xstream':
    plt.ylim(-23,500)
    ax1 = ax.twinx()
    p2 = ax1.scatter(xstream_x[0:7], (fpga_time_xstream_cardio[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(xstream_x[7:], (fpga_time_xstream_cardio[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,27.36)#(-50,500)
    ax1.set_ylabel("FPGA",size=9)

if detector == 'loda':
    plt.legend([p1, p2], ['CPU', 'FPGA'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          #frameon=False
          )
else:
    plt.legend([p1, (p2, p3)], ['CPU', 'FPGA(1,2)'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          #frameon=False
          )
#plt.xlabel('(a) Cardio')


ax=fig.add_subplot(142)
name_list = E_list
p1 = ax.scatter(E_list, (shuttle_mean_print), color='orangered', marker='.', alpha=0.01, s=30, label="CPU")
ax.set_ylabel("CPU",size=9)
plt.xlabel('(b) Shuttle')
if detector == 'loda':
    plt.ylim(0,650)
    ax1 = ax.twinx()
    p2 = ax1.scatter(loda_x[0:5], (fpga_time_loda_shuttle[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,203.58)#(-65,650)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'rshash':
    plt.ylim(0,1630)
    ax1 = ax.twinx()
    p2 = ax1.scatter(rshash_x[0:7], (fpga_time_rshash_shuttle[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(rshash_x[7:], (fpga_time_rshash_shuttle[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,212.46)#(-180,1800)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'xstream':
    plt.ylim(-270,7000)
    ax1 = ax.twinx()
    p2 = ax1.scatter(xstream_x[0:7], (fpga_time_xstream_shuttle[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(xstream_x[7:], (fpga_time_xstream_shuttle[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,240.42)#(-610,6100)
    ax1.set_ylabel("FPGA",size=9)
    
if detector == 'loda':
    plt.legend([p1, p2], ['CPU', 'FPGA'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          )
else:
    plt.legend([p1, (p2, p3)], ['CPU', 'FPGA(1,2)'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          )


ax=fig.add_subplot(143)
p1 = ax.scatter(E_list, (smtp1_mean_print), color='orangered', marker='.', alpha=0.01, s=30, label="CPU")
ax.set_ylabel("CPU",size=9)
plt.xlabel('(c) SMTP-3')
if detector == 'loda':
    plt.ylim(0,770)
    ax1 = ax.twinx()
    p2 = ax1.scatter(loda_x[0:5], (fpga_time_loda_smtp1[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,234.12)#(-77,770)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'rshash':
    plt.ylim(0,1760)
    ax1 = ax.twinx()
    p2 = ax1.scatter(rshash_x[0:7], (fpga_time_rshash_smtp1[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(rshash_x[7:], (fpga_time_rshash_smtp1[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,233.37)#(-170,1700)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'xstream':
    plt.ylim(-220,8000)
    ax1 = ax.twinx()
    p2 = ax1.scatter(xstream_x[0:7], (fpga_time_xstream_smtp1[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(xstream_x[7:], (fpga_time_xstream_smtp1[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,304.38)#(-530,5300)
    ax1.set_ylabel("FPGA",size=9)
    
if detector == 'loda':
    plt.legend([p1, p2], ['CPU', 'FPGA'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          )
else:
    plt.legend([p1, (p2, p3)], ['CPU', 'FPGA(1,2)'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          )


ax=fig.add_subplot(144)
name_list = E_list
p1 = ax.scatter(E_list, (http1_mean_print), color='orangered', marker='.', alpha=0.01, s=30, label="CPU")
ax.set_ylabel("CPU",size=9)
plt.xlabel('(d) HTTP-3')
if detector == 'loda':
    plt.ylim(0,4500)
    ax1 = ax.twinx()
    p2 = ax1.scatter(loda_x[0:5], (fpga_time_loda_http1[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,1367.7)#(-450,4500)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'rshash':
    plt.ylim(0,10500)
    ax1 = ax.twinx()
    p2 = ax1.scatter(rshash_x[0:7], (fpga_time_rshash_http1[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(rshash_x[7:], (fpga_time_rshash_http1[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,1366.77)#(-1000,10000)
    ax1.set_ylabel("FPGA",size=9)
elif detector == 'xstream':
    plt.ylim(0,47000)
    ax1 = ax.twinx()
    p2 = ax1.scatter(xstream_x[0:7], (fpga_time_xstream_http1[0:7]), color='green', marker='x', alpha=0.01, s=30, label="FPGA")
    p3 = ax1.scatter(xstream_x[7:], (fpga_time_xstream_http1[7:]), color='black', marker='x', alpha=0.01, s=30, label="FPGA")
    plt.ylim(0,1785.21)#(-3200,32000)
    ax1.set_ylabel("FPGA",size=9)
    
if detector == 'loda':
    plt.legend([p1, p2], ['CPU', 'FPGA'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          )
else:
    plt.legend([p1, (p2, p3)], ['CPU', 'FPGA(1,2)'], scatterpoints=1,loc='upper left',fontsize =9,
          numpoints=1, handler_map={tuple: HandlerTuple(ndivide=None)},
          )



plt.tight_layout()

plt.savefig('./figures/ExTime_{detector}.eps'.format(detector=detector), dpi=600, format='eps')

