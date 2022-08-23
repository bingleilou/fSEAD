#include "combo.h"

void combo_max_i2(
    // Input
    hls::stream<DataBus> &IN1,
    hls::stream<DataBus> &IN2,
    hls::stream<DataBus> &IN3,
    hls::stream<DataBus> &IN4,
    // Output
    hls::stream<DataBus> &OUT
    ){
    #pragma HLS INTERFACE axis register both port=IN1
    #pragma HLS INTERFACE axis register both port=IN2
    #pragma HLS INTERFACE axis register both port=IN3
    #pragma HLS INTERFACE axis register both port=IN4
    #pragma HLS INTERFACE axis register both port=OUT

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


    interface_t max_s;
    interface_t temp = score_in[0];
    for (uint16_t i = 0 ; i < 2; i++) {
        #pragma HLS PIPELINE
        if (score_in[i]>temp){
            temp = score_in[i];
        }
    }
    max_s = temp;
    
    data_OUT.data = (float)max_s;
    data_OUT.last = (data_IN1.last)|(data_IN2.last);
    OUT << data_OUT;

}
