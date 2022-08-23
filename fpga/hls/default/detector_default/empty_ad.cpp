#include "empty_ad.h"

void empty_ad(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score
    ){
    #pragma HLS INTERFACE axis register both port=data
    #pragma HLS INTERFACE axis register both port=score
    #pragma HLS INTERFACE s_axilite register port=return

    DataBus_OUT score_out;
    DataBus_IN data_bf = data.read();
    score_out.data = data_bf.data;
    score_out.last = data_bf.last;
    score << score_out;
}
