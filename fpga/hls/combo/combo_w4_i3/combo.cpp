#include "combo.h"

void combo_weight_i3(
    // Input
    hls::stream<DataBus> &IN1,
    hls::stream<DataBus> &IN2,
    hls::stream<DataBus> &IN3,
    hls::stream<DataBus> &IN4,
    float w1,
    float w2,
    float w3,
    float w4,
    // Output
    hls::stream<DataBus> &OUT
    ){
    #pragma HLS INTERFACE axis register both port=IN1
    #pragma HLS INTERFACE axis register both port=IN2
    #pragma HLS INTERFACE axis register both port=IN3
    #pragma HLS INTERFACE axis register both port=IN4
    #pragma HLS INTERFACE axis register both port=OUT
    
    #pragma HLS INTERFACE s_axilite register port=w1
    #pragma HLS INTERFACE s_axilite register port=w2
    #pragma HLS INTERFACE s_axilite register port=w3
    #pragma HLS INTERFACE s_axilite register port=w4
    #pragma HLS INTERFACE s_axilite register port=return

    // Remove ap ctrl ports (ap_start, ap_ready, ap_idle, etc) since we only use the AXI-Stream ports
    //#pragma HLS INTERFACE ap_ctrl_none port=return

    DataBus data_OUT;
    DataBus data_IN1;
    DataBus data_IN2;
    DataBus data_IN3;
    DataBus data_IN4;
    interface_t score_in[4] = {0};

    data_IN1 = IN1.read();
    score_in[0] = (interface_t)data_IN1.data;

    data_IN2 = IN2.read();
    score_in[1] = (interface_t)data_IN2.data;

    data_IN3 = IN3.read();
    score_in[2] = (interface_t)data_IN3.data;


    accum_t combo_regression = (accum_t)(((accum_t)score_in[0]*(accum_t)w1 + (accum_t)score_in[1]*(accum_t)w2 + (accum_t)score_in[2]*(accum_t)w3)*(accum_t)0.333333333333333);
    data_OUT.data = (float)combo_regression;
    data_OUT.last = (data_IN1.last)|(data_IN2.last)|(data_IN3.last);
    OUT << data_OUT;

}
