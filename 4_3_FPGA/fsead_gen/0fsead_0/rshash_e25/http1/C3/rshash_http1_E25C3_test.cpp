#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "rshash_http1_E25C3.h"

#define SMAPLE_NUM 567498


template <class dataType, unsigned int samples, unsigned int window>
int read_file(const char * filename, dataType  **data){
    FILE *fp;
    fp = fopen(filename, "r");
    if (fp == 0) {
        return -1;
    }
    // Read data from file
    float newval;
    for (int ii = 0; ii < samples; ii++){
        for (int jj = 0; jj < window-1; jj++) {
            if (fscanf(fp, "%f,", &newval) != 0){
                data[ii][jj] = (dataType) newval;
            } else {
                return -2;
            }
        }
        if (fscanf(fp, "%f\n", &newval) != 0){
            data[ii][window-1] = (dataType) newval;
        } else {
            return -2;
        }
    }
    fclose(fp);
    return 0;
}

template <class dataType, unsigned int samples>
int write_file_1D(const char * filename, dataType data[samples]) {
      FILE *fp;
      fp = fopen(filename, "w");
      if (fp == 0) {
        return -1;
      }

      // Write data to file
      for (int ii = 0; ii < samples; ii++){
        float newval = (float) data[ii];
        fprintf(fp, "%f\n", newval);
       }
       fclose(fp);
       return 0;
}



int main(int argc, char **argv)
{
    int rval = 0;
    
    interface_t  **X;
    X = (interface_t **)malloc(sizeof(interface_t *) * SMAPLE_NUM);
    for (int i = 0; i<SMAPLE_NUM; i ++) {
        X[i] = (interface_t *)malloc(sizeof(interface_t) * DIM_MAX);
    }

    interface_t *y;
    y = (interface_t *)malloc(sizeof(interface_t) * SMAPLE_NUM);
    float *tb_score_rshash;
    tb_score_rshash = (float *)malloc(sizeof(float) * SMAPLE_NUM);
    rval = read_file<interface_t, SMAPLE_NUM, DIM_MAX>("data/http1_X", X);

    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        hls::stream<DataBus_OUT> score_rshash;
        for (int idim=0; idim < DIM_MAX; idim++) {
            hls::stream<DataBus_IN> data_str;
            DataBus_IN data_str_bus;
            data_str_bus.data = X[isample][idim];
            if(isample == SMAPLE_NUM-1){
                data_str_bus.last = 1;
            }else{
                data_str_bus.last = 0;
            }
            data_str << data_str_bus;
                rshash_http1_c3(data_str, score_rshash);

        }

        interface_t score_stream_rshash;
        DataBus_OUT score_rshash_bus;
        score_rshash_bus= score_rshash.read();
        score_stream_rshash = score_rshash_bus.data;
        tb_score_rshash[isample] = score_stream_rshash;
    }
    rval = write_file_1D<float, SMAPLE_NUM>("D:/HLS/0fsead_0/rshash_e25/http1/C3/data/score_rshash_http1", tb_score_rshash);
}