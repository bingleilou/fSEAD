#include "empty_combo.h"

void empty_combo(
    hls::stream<DataBus_IN> &IN1,
	hls::stream<DataBus_IN> &IN2,
	hls::stream<DataBus_IN> &IN3,
	hls::stream<DataBus_IN> &IN4,
    hls::stream<DataBus_OUT> &OUT
    ){
    #pragma HLS INTERFACE axis register both port=IN1
	#pragma HLS INTERFACE axis register both port=IN2
	#pragma HLS INTERFACE axis register both port=IN3
	#pragma HLS INTERFACE axis register both port=IN4
    #pragma HLS INTERFACE axis register both port=OUT
    #pragma HLS INTERFACE s_axilite register port=return

    DataBus_OUT score_out;
    DataBus_IN data_bf1 = IN1.read();

    score_out.data = data_bf1.data;
    score_out.last = data_bf1.last;
    OUT << score_out;
}
