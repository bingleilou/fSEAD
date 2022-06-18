#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "xstream_cardio_E20C7.h"

#define SMAPLE_NUM 1831


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
    float *tb_score_xstream;
    tb_score_xstream = (float *)malloc(sizeof(float) * SMAPLE_NUM);
    rval = read_file<interface_t, SMAPLE_NUM, DIM_MAX>("data/cardio_X", X);

    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        hls::stream<DataBus_OUT> score_xstream;
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
                xstream_cardio_c7(data_str, score_xstream);

        }

        interface_t score_stream_xstream;
        DataBus_OUT score_xstream_bus;
        score_xstream_bus= score_xstream.read();
        score_stream_xstream = score_xstream_bus.data;
        tb_score_xstream[isample] = score_stream_xstream;
    }
    rval = write_file_1D<float, SMAPLE_NUM>("D:/HLS/0fsead_0/xstream_e20/cardio/C7/data/score_xstream_cardio", tb_score_xstream);
}