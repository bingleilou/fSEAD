import numpy as np
from optparse import OptionParser

optParser = OptionParser()
optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
(options, args) = optParser.parse_args()
ad         = 'xstream'
data       = options.data_name


batch_size = 128
hash_num = 2
matrix_col  = 128
k_num = 20


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

E_list = [140]
run_num = 1

for i in range(len(E_list)):
    for m in range(run_num):
        index = E_list[i]
        gcc_path = "./{ad}/{data}/".format(ad=ad,data=data)
        ####################################################################
        ########                 GENERATE GCC-C file                ########
        ####################################################################
        f = open(gcc_path + 'xstream_'+str(data)+'E'+str(index)+'.cpp', "w")
        s='''#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
'''
        f.write(s)
        f.write('#include \"xstream_'+str(data)+'E'+str(index)+'.h\"' + "\n")
        f.write('\n')
        f.write('#define SMAPLE_NUM '+ str(data_len) + '\n')
        f.write('#define MAX_THREADS 4\n')
        f.write('using namespace std;\n')
        f.write('\n')
        f_params = open(param_path + 'params_gcc_xstream_'+'E'+str(index)+'.h', "r")
        ss = f_params.read()
        f.write(ss)

        s='''
typedef struct thread_data {
    float **X;
    float *result;
} thread_data;

int    windows_value[ENSEMBLE][HASH_NUM][BATCH_SIZE] = {0};
int    windows_num[ENSEMBLE][HASH_NUM][BATCH_SIZE] = {0};
int    V_c[ENSEMBLE][HASH_NUM][BATCH_SIZE] = {0};
int    N_c[ENSEMBLE][HASH_NUM] = {0};

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

void *xstream_ensemble_0(void *arg) {
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
            char perbins_hash[HASH_NUM][K_NUM] = {0};
            float perbins[K_NUM] = {0};
            int depthcount[K_NUM] = {0};
            float Y_c[K_NUM] = {0};

            for(int k = 0; k < K_NUM; k++) {
                Y_c[k] = 0;
                perbins[k] = 0;
                perbins_hash[0][k] = 0;
                perbins_hash[1][k] = 0;
                depthcount[k] = 0;
            }

            for(int dim = 0; dim < DIM_MAX; dim++) {
                for(int kk = 0; kk < K_NUM; kk++) {
                    Y_c[kk] += tdata->X[isample][dim] * xstream_R_T[dim][kk];
                }
            }

            for(int row = 0; row < HASH_NUM; row++) {
                int  f = (int)xstream_fs[r][row];
                depthcount[f] += 1;
                if(depthcount[f]==1){
                    perbins[f] = (float)((Y_c[f]+xstream_shift[r][f])*xstream_deltamax[f]);
                }else{
                    perbins[f] = perbins[f] + perbins[f] + (float)xstream_shift_deltamax[r][f];
                }
                perbins_hash[row][f] =  (char)((uint32_t)(floor(perbins[f])));
            }

            // ****************************************
            // HASH FUNCTION
            // ****************************************
            uint16_t value[HASH_NUM] = {0};
            for(uint32_t row = 0; row < HASH_NUM; row++){
                uint32_t hash = row;
                for(int dim = 0; dim < K_NUM; dim++){
                    hash += (uint32_t)perbins_hash[row][dim];
                    hash += hash << 10;
                    hash ^= hash >> 6;
                }
                hash += hash << 3;
                hash ^= hash >> 11;
                hash += hash << 15;
                value[row] = (uint16_t)(hash % uint32_t(MATRIX_COL));
            }

            float score_hash[HASH_NUM] = {0};
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

                if(VC_value > BATCH_SIZE-1){VC_value = BATCH_SIZE-1;}
                else if(VC_value < 0){VC_value = 0;}
                else{VC_value = VC_value;}
                score_hash[row] = (float)log_LUT_xstream_d0[VC_value] + (float)row;
            }
            float c = 0;
            float temp = score_hash[0];
            for (int row = 0 ; row < HASH_NUM; row++) {
                if (score_hash[row]<temp){
                    temp = score_hash[row];
                }
            }
            c = temp;
            score_accum -= (float)c;
        }
        pthread_mutex_lock( &mutex1 );
        score[isample] += score_accum/(float)ENSEMBLE;
        pthread_mutex_unlock( &mutex1 );
        tdata->result[isample] = score[isample];
    }
}

void *xstream_ensemble_1(void *arg) {
    thread_data *tdata=(thread_data *)arg;
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
            char perbins_hash[HASH_NUM][K_NUM] = {0};
            float perbins[K_NUM] = {0};
            int depthcount[K_NUM] = {0};
            float Y_c[K_NUM] = {0};

            for(int k = 0; k < K_NUM; k++) {
                Y_c[k] = 0;
                perbins[k] = 0;
                perbins_hash[0][k] = 0;
                perbins_hash[1][k] = 0;
                depthcount[k] = 0;
            }

            for(int dim = 0; dim < DIM_MAX; dim++) {
                for(int kk = 0; kk < K_NUM; kk++) {
                    Y_c[kk] += tdata->X[isample][dim] * xstream_R_T[dim][kk];
                }
            }

            for(int row = 0; row < HASH_NUM; row++) {
                int  f = (int)xstream_fs[r][row];
                depthcount[f] += 1;
                if(depthcount[f]==1){
                    perbins[f] = (float)((Y_c[f]+xstream_shift[r][f])*xstream_deltamax[f]);
                }else{
                    perbins[f] = perbins[f] + perbins[f] + (float)xstream_shift_deltamax[r][f];
                }
                perbins_hash[row][f] =  (char)((uint32_t)(floor(perbins[f])));
            }

            // ****************************************
            // HASH FUNCTION
            // ****************************************
            uint16_t value[HASH_NUM] = {0};
            for(uint32_t row = 0; row < HASH_NUM; row++){
                uint32_t hash = row;
                for(int dim = 0; dim < K_NUM; dim++){
                    hash += (uint32_t)perbins_hash[row][dim];
                    hash += hash << 10;
                    hash ^= hash >> 6;
                }
                hash += hash << 3;
                hash ^= hash >> 11;
                hash += hash << 15;
                value[row] = (uint16_t)(hash % uint32_t(MATRIX_COL));
            }

            float score_hash[HASH_NUM] = {0};
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

                if(VC_value > BATCH_SIZE-1){VC_value = BATCH_SIZE-1;}
                else if(VC_value < 0){VC_value = 0;}
                else{VC_value = VC_value;}
                score_hash[row] = (float)log_LUT_xstream_d0[VC_value] + (float)row;
            }
            float c = 0;
            float temp = score_hash[0];
            for (int row = 0 ; row < HASH_NUM; row++) {
                if (score_hash[row]<temp){
                    temp = score_hash[row];
                }
            }
            c = temp;
            score_accum -= (float)c;
        }
        pthread_mutex_lock( &mutex1 );
        score[isample] += score_accum/(float)ENSEMBLE;
        pthread_mutex_unlock( &mutex1 );
        tdata->result[isample] = score[isample];
    }
}

void *xstream_ensemble_2(void *arg) {
    thread_data *tdata=(thread_data *)arg;
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
            char perbins_hash[HASH_NUM][K_NUM] = {0};
            float perbins[K_NUM] = {0};
            int depthcount[K_NUM] = {0};
            float Y_c[K_NUM] = {0};

            for(int k = 0; k < K_NUM; k++) {
                Y_c[k] = 0;
                perbins[k] = 0;
                perbins_hash[0][k] = 0;
                perbins_hash[1][k] = 0;
                depthcount[k] = 0;
            }

            for(int dim = 0; dim < DIM_MAX; dim++) {
                for(int kk = 0; kk < K_NUM; kk++) {
                    Y_c[kk] += tdata->X[isample][dim] * xstream_R_T[dim][kk];
                }
            }

            for(int row = 0; row < HASH_NUM; row++) {
                int  f = (int)xstream_fs[r][row];
                depthcount[f] += 1;
                if(depthcount[f]==1){
                    perbins[f] = (float)((Y_c[f]+xstream_shift[r][f])*xstream_deltamax[f]);
                }else{
                    perbins[f] = perbins[f] + perbins[f] + (float)xstream_shift_deltamax[r][f];
                }
                perbins_hash[row][f] =  (char)((uint32_t)(floor(perbins[f])));
            }

            // ****************************************
            // HASH FUNCTION
            // ****************************************
            uint16_t value[HASH_NUM] = {0};
            for(uint32_t row = 0; row < HASH_NUM; row++){
                uint32_t hash = row;
                for(int dim = 0; dim < K_NUM; dim++){
                    hash += (uint32_t)perbins_hash[row][dim];
                    hash += hash << 10;
                    hash ^= hash >> 6;
                }
                hash += hash << 3;
                hash ^= hash >> 11;
                hash += hash << 15;
                value[row] = (uint16_t)(hash % uint32_t(MATRIX_COL));
            }

            float score_hash[HASH_NUM] = {0};
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

                if(VC_value > BATCH_SIZE-1){VC_value = BATCH_SIZE-1;}
                else if(VC_value < 0){VC_value = 0;}
                else{VC_value = VC_value;}
                score_hash[row] = (float)log_LUT_xstream_d0[VC_value] + (float)row;
            }
            float c = 0;
            float temp = score_hash[0];
            for (int row = 0 ; row < HASH_NUM; row++) {
                if (score_hash[row]<temp){
                    temp = score_hash[row];
                }
            }
            c = temp;
            score_accum -= (float)c;
        }
        pthread_mutex_lock( &mutex1 );
        score[isample] += score_accum/(float)ENSEMBLE;
        pthread_mutex_unlock( &mutex1 );
        tdata->result[isample] = score[isample];
    }
}

void *xstream_ensemble_3(void *arg) {
    thread_data *tdata=(thread_data *)arg;
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
            char perbins_hash[HASH_NUM][K_NUM] = {0};
            float perbins[K_NUM] = {0};
            int depthcount[K_NUM] = {0};
            float Y_c[K_NUM] = {0};

            for(int k = 0; k < K_NUM; k++) {
                Y_c[k] = 0;
                perbins[k] = 0;
                perbins_hash[0][k] = 0;
                perbins_hash[1][k] = 0;
                depthcount[k] = 0;
            }

            for(int dim = 0; dim < DIM_MAX; dim++) {
                for(int kk = 0; kk < K_NUM; kk++) {
                    Y_c[kk] += tdata->X[isample][dim] * xstream_R_T[dim][kk];
                }
            }

            for(int row = 0; row < HASH_NUM; row++) {
                int  f = (int)xstream_fs[r][row];
                depthcount[f] += 1;
                if(depthcount[f]==1){
                    perbins[f] = (float)((Y_c[f]+xstream_shift[r][f])*xstream_deltamax[f]);
                }else{
                    perbins[f] = perbins[f] + perbins[f] + (float)xstream_shift_deltamax[r][f];
                }
                perbins_hash[row][f] =  (char)((uint32_t)(floor(perbins[f])));
            }

            // ****************************************
            // HASH FUNCTION
            // ****************************************
            uint16_t value[HASH_NUM] = {0};
            for(uint32_t row = 0; row < HASH_NUM; row++){
                uint32_t hash = row;
                for(int dim = 0; dim < K_NUM; dim++){
                    hash += (uint32_t)perbins_hash[row][dim];
                    hash += hash << 10;
                    hash ^= hash >> 6;
                }
                hash += hash << 3;
                hash ^= hash >> 11;
                hash += hash << 15;
                value[row] = (uint16_t)(hash % uint32_t(MATRIX_COL));
            }

            float score_hash[HASH_NUM] = {0};
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

                if(VC_value > BATCH_SIZE-1){VC_value = BATCH_SIZE-1;}
                else if(VC_value < 0){VC_value = 0;}
                else{VC_value = VC_value;}
                score_hash[row] = (float)log_LUT_xstream_d0[VC_value] + (float)row;
            }
            float c = 0;
            float temp = score_hash[0];
            for (int row = 0 ; row < HASH_NUM; row++) {
                if (score_hash[row]<temp){
                    temp = score_hash[row];
                }
            }
            c = temp;
            score_accum -= (float)c;
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

    pthread_create(&tid0, NULL, xstream_ensemble_0, (void *)&tdata0);
    pthread_create(&tid1, NULL, xstream_ensemble_1, (void *)&tdata0);
    pthread_create(&tid2, NULL, xstream_ensemble_2, (void *)&tdata0);
    pthread_create(&tid3, NULL, xstream_ensemble_3, (void *)&tdata0);
    
    pthread_join(tid0, NULL);
    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);
    pthread_join(tid3, NULL);

  
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        cout << setprecision(32) << (tdata0.result[isample] - (float)bottom_xstream)*(float)delta_xstream << endl;
    }
    pthread_exit(NULL);

    return 0;
}
    '''
        f.write(s)


        ####################################################################
        ########                 GENERATE GCC-H file                ########
        ####################################################################
        f = open(gcc_path + 'xstream_'+str(data)+'E'+str(index)+'.h', "w")
        s='''#ifndef XSTREAM_GENERATOR_1_H_
#define XSTREAM_GENERATOR_1_H_

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
        f.write('#define K_NUM '+str(k_num)+'\n')
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
        s='''
start_time=$(date +%s%N)
echo \"training: Doing\"
'''
        f.write(s)
        f.write('time ./xstream_'+str(data)+'E'+str(index)+' '+str(data_len)+' > scores\n')
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
        f.write('xstream_'+str(data)+'E'+str(index)+': $(OBJS)\n')
        s='''		$(CC) $(CFLAGS) $^ -o $@ -lpthread

.cpp.o:
		$(CC) $(CFLAGS) -c $<

clean:
'''
        f.write(s)

        f.write('		rm -f loda_'+str(data)+'E'+str(index)+' $(OBJS) *.o' + ' runtime scores\n')







