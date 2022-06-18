import numpy as np
from optparse import OptionParser

optParser = OptionParser()
optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
(options, args) = optParser.parse_args()
ad         = 'loda'
data       = options.data_name


batch_size = 128
n_bins  = 20

if data == 'cardio':
    dim_max = 21
    data_len = 1831
elif data == 'shuttle':
    dim_max = 9
    data_len = 49097
elif data == 'smtp1':
    dim_max = 3
    data_len = 95156
elif data == 'http1':
    dim_max = 3
    data_len = 567498
else:
    print("data name set error, which is: ", data)
    sys.exit()


param_path = "./params/{ad}/{data}/".format(ad=ad,data=data)

E_list = [245]
run_num = 1

for i in range(len(E_list)):
    for m in range(run_num):
        index = E_list[i]
        gcc_path = "./0gcc_0/max_ensemble_gcc/{ad}/{data}/".format(ad=ad,data=data)
        ####################################################################
        ########                 GENERATE GCC-C file                ########
        ####################################################################
        f = open(gcc_path + 'loda_'+str(data)+'E'+str(index)+'.cpp', "w")
        s='''
#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
'''
        f.write(s)
        f.write('#include \"loda_'+str(data)+'E'+str(index)+'.h\"' + "\n")
        f.write('\n')
        f.write('#define SMAPLE_NUM '+ str(data_len) + '\n')
        f.write('using namespace std;\n')
        f.write('\n')
        f_params = open(param_path + 'params_gcc_loda_'+'E'+str(index)+'.h', "r")
        ss = f_params.read()
        f.write(ss)

        s='''
int    windows_value[ENSEMBLE][BATCH_SIZE] = {0};
int    windows_num[ENSEMBLE][BATCH_SIZE] = {0};
int    V_c[ENSEMBLE][BATCH_SIZE] = {0};
int    N_c[ENSEMBLE] = {0};
int    win_idx = 0;


float loda_ensemble(float X[DIM_MAX]) {

    win_idx += 1;
    if (win_idx >= BATCH_SIZE){
        win_idx = 0;
    }
    float score = 0;

    for(int r = 0; r < ENSEMBLE; r++) {
        // ****************************************
        // Random Projection
        // ****************************************
        float projected_X_temp = 0;
        for(int dim = 0; dim < DIM_MAX; dim++) {
            projected_X_temp += X[dim] * loda_projections[r][dim];
        }

        int idx_temp = 0;
        int VC_table = 0;
        int value = 0;

        idx_temp = (int)((projected_X_temp - loda_min_X[r])*(loda_delta[r]));
        if (idx_temp >= N_BINS){
            idx_temp = N_BINS - 1;
        }
        if (idx_temp <= 0){
            idx_temp = 0;
        }
        value = idx_temp;

        int VC_value = 0;
        // ****************************************
        // Slide Windows
        // ****************************************
        int valueFromWin;
        int nFromWin;

        VC_value = V_c[r][value];

        V_c[r][value] += 1;
        N_c[r] += 1;

        valueFromWin = windows_value[r][win_idx];
        nFromWin = windows_num[r][win_idx];

        V_c[r][valueFromWin] -= nFromWin;
        N_c[r] -= nFromWin;

        windows_value[r][win_idx] = value;
        windows_num[r][win_idx] = 1;

        VC_table = VC_value;
        if(VC_table > BATCH_SIZE-1){
            VC_table = BATCH_SIZE - 1;
        }
        float c;
        if(VC_table > 0){
            c= (float)log_LUT_loda[VC_table];
        }
        else{
            c = 15.0;
        }
        score += c;

    }
    return score;
}

float data_window [DIM_MAX] = {0};
int count = 0;

void loda_cardio(float data){
    float anomalyscore;
    bool flag;

    flag = 0;
    count += 1;
    if (count == DIM_MAX){
        count = 0;
        flag = 1;
    }

    for (int i = 0; i < DIM_MAX-1; i++) {
        data_window[i] = data_window[i+1];
    }
    data_window[DIM_MAX-1] = (float)data;


    float score_out_fixed;
    if(flag == 1){
        score_out_fixed = loda_ensemble(data_window);
        anomalyscore = (float)(((double)score_out_fixed/(double)ENSEMBLE - (double)bottom_loda)*(double)delta_loda);
        cout << setprecision(26) << anomalyscore << endl;;
    }
}


int main(int argc, char **argv)
{
    // Load data from file

    stringstream ss;
    string line;
    while (getline(cin, line)) {
        ss.clear();
        ss.str(line);
        string field;
        while (ss >> field) {
            loda_cardio(std::stof(field));
        }
    }
}
    '''
        f.write(s)


        ####################################################################
        ########                 GENERATE GCC-H file                ########
        ####################################################################
        f = open(gcc_path + 'loda_'+str(data)+'E'+str(index)+'.h', "w")
        s='''#ifndef LODA_GENERATOR_1_H_
#define LODA_GENERATOR_1_H_

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <iostream>

#include <cassert>
#include <chrono>
#include <iomanip>
#include <iostream>
#include <limits>
#include <random>
#include <sstream>
#include <string>
#include <tuple>
#include <unordered_map>
#include <vector>

// Prototype of top level function for C-synthesis
void loda_cardio(float data);

'''
        f.write(s)
        f.write('#define ENSEMBLE '+str(index)+'\n')
        f.write('#define DIM_MAX '+str(dim_max)+'\n')
        f.write('#define BATCH_SIZE '+str(batch_size)+'\n')
        f.write('#define N_BINS '+str(n_bins)+'\n')
        f.write('#endif')


        ####################################################################
        ########                 GENERATE RUN.sh file               ########
        ####################################################################
        f = open(gcc_path + 'run.sh', "w")

        f.write('#!/bin/bash'+'\n')
        f.write('\n')
        f.write('data=\"./../../../data_gcc/'+str(data)+'_X\"\n')
        s='''
start_time=$(date +%s%N)
echo \"training: Doing\"
'''
        f.write(s)
        f.write('time taskset -c 5 cat $data | ./loda_'+str(data)+'E'+str(index)+' '+str(data_len)+' > scores\n')
        s='''
echo \"testing: Doing\"

end_time=$(date +%s%N)
cost_time_us=$[ ($end_time-$start_time)/10**3 ] #us
cost_time_ms=$[ ($end_time-$start_time)/10**6 ] #ms
cost_time_s=$[ ($end_time-$start_time)/10**9 ] #s
echo \"Bash Execution time is $(($cost_time_s)) s\"
echo \"Bash Execution time is $(($cost_time_ms)) ms\"
echo \"Bash Execution time is $(($cost_time_us)) us\"
'''
        f.write(s)
        f.write('echo \"E'+str(index)+'(ms) \"$(($cost_time_ms)) >> ./runtime')

        ####################################################################
        ########                GENERATE Makefile file              ########
        ####################################################################
        f = open(gcc_path + 'Makefile', "w")
        s='''CC=g++
CFLAGS=-Wall --std=c++11 -g
SOURCES := $(wildcard *.cpp)
OBJS := $(SOURCES:.cpp=.o)

.PHONY: clean
'''
        f.write(s)
        f.write('loda_'+str(data)+'E'+str(index)+': $(OBJS)\n')
        s='''		$(CC) $(CFLAGS) $^ -o $@

.cpp.o:
		$(CC) $(CFLAGS) -c $<

clean:
'''
        f.write(s)

        f.write('		rm -f loda_'+str(data)+'E'+str(index)+' $(OBJS) *.o\n')







