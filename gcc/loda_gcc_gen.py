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


param_path = "./../python/params/{ad}/{data}/".format(ad=ad,data=data)

E_list = [245]
run_num = 1

for i in range(len(E_list)):
    for m in range(run_num):
        index = E_list[i]
        gcc_path = "./{ad}/{data}/".format(ad=ad,data=data)
        ####################################################################
        ########                 GENERATE GCC-C file                ########
        ####################################################################
        f = open(gcc_path + 'loda_'+str(data)+'E'+str(index)+'.cpp', "w")
        s='''#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
'''
        f.write(s)
        f.write('#include \"loda_'+str(data)+'E'+str(index)+'.h\"' + "\n")
        f.write('\n')
        f.write('#define SMAPLE_NUM '+ str(data_len) + '\n')
        f.write('#define MAX_THREADS 4\n')
        f.write('using namespace std;\n')
        f.write('\n')
        f_params = open(param_path + 'params_gcc_loda_'+'E'+str(index)+'.h', "r")
        ss = f_params.read()
        f.write(ss)

        s='''
typedef struct thread_data {
    float **X;
    float *result;
} thread_data;

int    windows_value[ENSEMBLE][BATCH_SIZE] = {0};
int    windows_num[ENSEMBLE][BATCH_SIZE] = {0};
int    V_c[ENSEMBLE][BATCH_SIZE] = {0};
int    N_c[ENSEMBLE] = {0};

float *score;

pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;



template <class dataType, int samples, int window>
int read_file(const char * filename, dataType  **data){
    FILE *fp;
    fp = fopen(filename, \"r\");
    if (fp == 0) {
        return -1;
    }
    // Read data from file
    float newval;
    for (int ii = 0; ii < samples; ii++){
        for (int jj = 0; jj < window-1; jj++) {
            if (fscanf(fp, \"%f,\", &newval) != 0){
                data[ii][jj] = (dataType) newval;
            } else {
                return -2;
            }
        }
        if (fscanf(fp, \"%f\\n\", &newval) != 0){
        	data[ii][window-1] = (dataType) newval;
        } else {
            return -2;
        }
    }
    fclose(fp);
    return 0;
}

void *loda_ensemble_0(void *arg) {
    thread_data *tdata=(thread_data *)arg;
    
    int    win_idx = 0;
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        win_idx += 1;
        if (win_idx >= BATCH_SIZE){
            win_idx = 0;
        }
        //float score = 0;
        float score_accum = 0;
        for(int r = 0; r < (int)((float)ENSEMBLE/(float)MAX_THREADS); r++) {
            // ****************************************
            // Random Projection
            // ****************************************
            float projected_X_temp = 0;
            for(int dim = 0; dim < DIM_MAX; dim++) {
                projected_X_temp += tdata->X[isample][dim] * loda_projections[r][dim];
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
            score_accum += (float)c;
        }
        pthread_mutex_lock( &mutex1 );
        score[isample] += score_accum/(float)ENSEMBLE;
        pthread_mutex_unlock( &mutex1 );
        tdata->result[isample] = score[isample];
    }
}

void *loda_ensemble_1(void *arg) {
    thread_data *tdata=(thread_data *)arg;
    int    windows_value[ENSEMBLE][BATCH_SIZE] = {0};
    int    windows_num[ENSEMBLE][BATCH_SIZE] = {0};
    int    V_c[ENSEMBLE][BATCH_SIZE] = {0};
    int    N_c[ENSEMBLE] = {0};
    int    win_idx = 0;    
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        win_idx += 1;
        if (win_idx >= BATCH_SIZE){
            win_idx = 0;
        }
        //float score = 0;
        float score_accum = 0;
        for(int r = (int)((float)ENSEMBLE/(float)MAX_THREADS); r < (int)((float)ENSEMBLE/(float)MAX_THREADS*2); r++) {
            // ****************************************
            // Random Projection
            // ****************************************
            float projected_X_temp = 0;
            for(int dim = 0; dim < DIM_MAX; dim++) {
                projected_X_temp += tdata->X[isample][dim] * loda_projections[r][dim];
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
            score_accum += (float)c;
        }
        pthread_mutex_lock( &mutex1 );
        score[isample] += score_accum/(float)ENSEMBLE;
        pthread_mutex_unlock( &mutex1 );
        tdata->result[isample] = score[isample];
    }
}

void *loda_ensemble_2(void *arg) {
    thread_data *tdata=(thread_data *)arg;
    int    windows_value[ENSEMBLE][BATCH_SIZE] = {0};
    int    windows_num[ENSEMBLE][BATCH_SIZE] = {0};
    int    V_c[ENSEMBLE][BATCH_SIZE] = {0};
    int    N_c[ENSEMBLE] = {0};
    int    win_idx = 0;    
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        win_idx += 1;
        if (win_idx >= BATCH_SIZE){
            win_idx = 0;
        }
        //float score = 0;
        float score_accum = 0;
        for(int r = (int)((float)ENSEMBLE/(float)MAX_THREADS*2); r < (int)((float)ENSEMBLE/(float)MAX_THREADS*3); r++) {
            // ****************************************
            // Random Projection
            // ****************************************
            float projected_X_temp = 0;
            for(int dim = 0; dim < DIM_MAX; dim++) {
                projected_X_temp += tdata->X[isample][dim] * loda_projections[r][dim];
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
            score_accum += (float)c;
        }
        pthread_mutex_lock( &mutex1 );
        score[isample] += score_accum/(float)ENSEMBLE;
        pthread_mutex_unlock( &mutex1 );
        tdata->result[isample] = score[isample];
    }
}

void *loda_ensemble_3(void *arg) {
    thread_data *tdata=(thread_data *)arg;
    int    windows_value[ENSEMBLE][BATCH_SIZE] = {0};
    int    windows_num[ENSEMBLE][BATCH_SIZE] = {0};
    int    V_c[ENSEMBLE][BATCH_SIZE] = {0};
    int    N_c[ENSEMBLE] = {0};
    int    win_idx = 0;    
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        win_idx += 1;
        if (win_idx >= BATCH_SIZE){
            win_idx = 0;
        }
        //float score = 0;
        float score_accum = 0;
        for(int r = (int)((float)ENSEMBLE/(float)MAX_THREADS*3); r < (int)((float)ENSEMBLE/(float)MAX_THREADS*4); r++) {
            // ****************************************
            // Random Projection
            // ****************************************
            float projected_X_temp = 0;
            for(int dim = 0; dim < DIM_MAX; dim++) {
                projected_X_temp += tdata->X[isample][dim] * loda_projections[r][dim];
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
            score_accum += (float)c;
        }
        pthread_mutex_lock( &mutex1 );
        score[isample] += score_accum/(float)ENSEMBLE;
        pthread_mutex_unlock( &mutex1 );
        tdata->result[isample] = score[isample];
    }
}


int main(int argc, char **argv)
{
    pthread_t tid0;
    pthread_t tid1;
    pthread_t tid2;
    pthread_t tid3;
    
    
    thread_data tdata0;
    tdata0.X = (float **)malloc(sizeof(float *) * SMAPLE_NUM);
    for (int i = 0; i<SMAPLE_NUM; i ++) {
        tdata0.X[i] = (float *)malloc(sizeof(float) * DIM_MAX);
    }
    tdata0.result = (float *)malloc(sizeof(float) * SMAPLE_NUM);
    
    score = (float *)malloc(sizeof(float) * SMAPLE_NUM);
    
    float  **X;
    X = (float **)malloc(sizeof(float *) * SMAPLE_NUM);
    for (int i = 0; i<SMAPLE_NUM; i ++) {
        X[i] = (float *)malloc(sizeof(float) * DIM_MAX);
    }
'''
        f.write(s)
        f.write('    int rval = read_file<float, SMAPLE_NUM, DIM_MAX>(\"./../../data_gcc/'+str(ad)+'/'+str(data)+'_X\",X);\n')
        s='''
    rval = rval;
    
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        for(int idim=0; idim<DIM_MAX; idim++){
            tdata0.X[isample][idim]=X[isample][idim];
        }
    }

    pthread_create(&tid0, NULL, loda_ensemble_0, (void *)&tdata0);
    pthread_create(&tid1, NULL, loda_ensemble_1, (void *)&tdata0);
    pthread_create(&tid2, NULL, loda_ensemble_2, (void *)&tdata0);
    pthread_create(&tid3, NULL, loda_ensemble_3, (void *)&tdata0);
    
    
    pthread_join(tid0, NULL);
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);
    pthread_join(tid3, NULL);
  
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        cout << setprecision(32) << (tdata0.result[isample] - bottom_loda)*delta_loda << endl;
    }
    pthread_exit(NULL);

    return 0;
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
        s='''
start_time=$(date +%s%N)
echo \"training: Doing\"
'''
        f.write(s)
        f.write('time ./loda_'+str(data)+'E'+str(index)+' '+str(data_len)+' > scores\n')
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
CFLAGS=-Wall --std=c++14 -g -O3
SOURCES := $(wildcard *.cpp)
OBJS := $(SOURCES:.cpp=.o)

.PHONY: clean
'''
        f.write(s)
        f.write('loda_'+str(data)+'E'+str(index)+': $(OBJS)\n')
        s='''		$(CC) $(CFLAGS) $^ -o $@ -lpthread

.cpp.o:
		$(CC) $(CFLAGS) -c $<

clean:
'''
        f.write(s)

        f.write('		rm -f loda_'+str(data)+'E'+str(index)+' $(OBJS) *.o' + ' runtime scores\n')







