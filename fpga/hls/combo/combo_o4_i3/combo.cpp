#include "combo.h"

void combo_or_i3(
    // Input
    hls::stream<DataBus> &IN1,
    hls::stream<DataBus> &IN2,
    hls::stream<DataBus> &IN3,
    hls::stream<DataBus> &IN4,
    float                threshold,
    // Output
    hls::stream<DataBus> &OUT
    
    ){
    #pragma HLS INTERFACE axis register both port=IN1
    #pragma HLS INTERFACE axis register both port=IN2
    #pragma HLS INTERFACE axis register both port=IN3
    #pragma HLS INTERFACE axis register both port=IN4
    #pragma HLS INTERFACE axis register both port=OUT

    #pragma HLS INTERFACE s_axilite register port=threshold
    #pragma HLS INTERFACE s_axilite register port=return

    // Remove ap ctrl ports (ap_start, ap_ready, ap_idle, etc) since we only use the AXI-Stream ports
    //#pragma HLS INTERFACE ap_ctrl_none port=return

    DataBus data_OUT;
    DataBus data_IN1;
    DataBus data_IN2;
    DataBus data_IN3;
    interface_t score_in1;
    interface_t score_in2;
    interface_t score_in3;

    data_IN1 = IN1.read();
    score_in1 = (interface_t)data_IN1.data;

    data_IN2 = IN2.read();
    score_in2 = (interface_t)data_IN2.data;

    data_IN3 = IN3.read();
    score_in3 = (interface_t)data_IN3.data;

    bool label1;
    bool label2;
    bool label3;
    
    label1 = score_in1 > (interface_t)threshold ? 1 : 0;
    label2 = score_in2 > (interface_t)threshold ? 1 : 0;
    label3 = score_in3 > (interface_t)threshold ? 1 : 0;
    
    bool combo_classification = label1 | label2 | label3;
    data_OUT.data = (float)combo_classification;
    data_OUT.last = (data_IN1.last)|(data_IN2.last)|(data_IN3.last);
    OUT << data_OUT;

}
