import numpy as np
from optparse import OptionParser

optParser = OptionParser()
optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
(options, args) = optParser.parse_args()
ad         = 'rshash'
data       = options.data_name


batch_size = 128
hash_num = 2
matrix_col  = 128


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

E_list = [25,50,75,100,125,150,175]
run_num = 10

for i in range(len(E_list)):
    for m in range(run_num):
        index = E_list[i]
        gcc_path = "./gcc/{ad}/{data}/E{e}/M{m}/".format(ad=ad,data=data,e=index,m=m+1)
        ####################################################################
        ########                 GENERATE GCC-C file                ########
        ####################################################################
        f = open(gcc_path + 'rshash_'+str(data)+'E'+str(index)+'.cpp', "w")
        s='''#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
'''
        f.write(s)
        f.write('#include \"rshash_'+str(data)+'E'+str(index)+'.h\"' + "\n")
        f.write('\n')
        f.write('#define SMAPLE_NUM '+ str(data_len) + '\n')
        f.write('using namespace std;\n')
        f.write('\n')
        f_params = open(param_path + 'params_gcc_rshash_'+str(data)+'_'+'E'+str(index)+'_M'+str(m+1)+'.h', "r")
        ss = f_params.read()
        f.write(ss)

        s='''
int    windows_value[ENSEMBLE][HASH_NUM][BATCH_SIZE] = {0};
int    windows_num[ENSEMBLE][HASH_NUM][BATCH_SIZE] = {0};
int    V_c[ENSEMBLE][HASH_NUM][BATCH_SIZE] = {0};
int    N_c[ENSEMBLE][HASH_NUM] = {0};
int    win_idx = 0;


float rshash_ensemble(float X[DIM_MAX]) {
    
    win_idx += 1;
    if (win_idx >= BATCH_SIZE){
        win_idx = 0;
    }
    float score = 0;
    
    for(int r = 0; r < ENSEMBLE; r++) {
        // ****************************************
        // Random Projection
        // ****************************************
        char projected_X8_hash[DIM_MAX] = {0};
        float X_norm = 0;
        for(int dim = 0; dim < DIM_MAX; dim++) {
            X_norm = (X[dim] - rshash_min_X[dim])*rshash_delta_X[dim];
            char projected_X_8 = (char)((X_norm + rshash_alpha[r][dim])*rshash_f[r]);
            projected_X8_hash[dim] = projected_X_8;
        }
        
        // ****************************************
        // HASH FUNCTION
        // ****************************************
        uint16_t value[HASH_NUM] = {0};
        for(uint32_t row = 0; row < HASH_NUM; row++){
            uint32_t hash = row;
            for(int dim = 0; dim < DIM_MAX; dim++){
                hash += (uint32_t)projected_X8_hash[dim];
                hash += hash << 10;
                hash ^= hash >> 6;
            }
            hash += hash << 3;
            hash ^= hash >> 11;
            hash += hash << 15;
            value[row] = (uint16_t)(hash % uint32_t(MATRIX_COL));
        }
        
        
        int VC_table[HASH_NUM]={0};
        //int NC_table[HASH_NUM]={0};
        for(int row = 0; row < HASH_NUM; row++) {
            int VC_value= 0;
            //int NC_value= 0;
            // ****************************************
            // Slide Windows
            // ****************************************
            int valueFromWin= 0;
            int nFromWin= 0;
            VC_value = V_c[r][row][value[row]];

            V_c[r][row][value[row]] += 1;
            N_c[r][row] += 1;

            valueFromWin = windows_value[r][row][win_idx];
            nFromWin = windows_num[r][row][win_idx];

            V_c[r][row][valueFromWin] -= nFromWin;
            N_c[r][row] -= nFromWin;

            windows_value[r][row][win_idx] = value[row];
            windows_num[r][row][win_idx] = 1;

            VC_table[row] = VC_value;
        }
        int min_c;
        int temp = VC_table[0];
        for (int row = 0 ; row < HASH_NUM; row++) {
            if (VC_table[row]<temp){
                temp = VC_table[row];
            }
        }
        min_c = temp;

        if(min_c > BATCH_SIZE-1){min_c = BATCH_SIZE-1;}
        if(min_c < 0){min_c = 0;}
        float c;
        c = (float)log_LUT_rshash[min_c];
        score += c;
    }
    return score;
}

float data_window [DIM_MAX] = {0};
int count = 0;

void rshash_cardio(float data){
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
        score_out_fixed = rshash_ensemble(data_window);
        anomalyscore = (float)(((double)score_out_fixed/(double)ENSEMBLE - (double)bottom_rshash)*(double)delta_rshash);
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
            rshash_cardio(std::stof(field));
        }
    }
}
    '''
        f.write(s)


        ####################################################################
        ########                 GENERATE GCC-H file                ########
        ####################################################################
        f = open(gcc_path + 'rshash_'+str(data)+'E'+str(index)+'.h', "w")
        s='''#ifndef RSHASH_GENERATOR_1_H_
#define RSHASH_GENERATOR_1_H_

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
void rshash_cardio(float data);

'''
        f.write(s)
        f.write('#define ENSEMBLE '+str(index)+'\n')
        f.write('#define DIM_MAX '+str(dim_max)+'\n')
        f.write('#define BATCH_SIZE '+str(batch_size)+'\n')
        f.write('#define HASH_NUM '+str(hash_num)+'\n')
        f.write('#define MATRIX_COL '+str(matrix_col)+'\n')
        
        f.write('\n')
        f.write('typedef unsigned short int uint16_t;'+'\n')
        f.write('typedef unsigned int uint32_t;'+'\n')
        f.write('#endif')


        ####################################################################
        ########                 GENERATE RUN.sh file               ########
        ####################################################################
        f = open(gcc_path + 'run.sh', "w")

        f.write('#!/bin/bash'+'\n')
        f.write('\n')
        f.write('data=\"./../../../../data_gcc/'+str(data)+'_X\"\n')
        s='''
start_time=$(date +%s%N)
echo \"training: Doing\"
'''
        f.write(s)
        f.write('time taskset -c 5 cat $data | ./rshash_'+str(data)+'E'+str(index)+' '+str(data_len)+' > scores\n')
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
        f.write('echo \"E'+str(index)+'(ms) \"$(($cost_time_ms)) >> ./../runtime')

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
        f.write('rshash_'+str(data)+'E'+str(index)+': $(OBJS)\n')
        s='''		$(CC) $(CFLAGS) $^ -o $@

.cpp.o:
		$(CC) $(CFLAGS) -c $<

clean:
'''
        f.write(s)

        f.write('		rm -f rshash_'+str(data)+'E'+str(index)+' $(OBJS) *.o\n')







