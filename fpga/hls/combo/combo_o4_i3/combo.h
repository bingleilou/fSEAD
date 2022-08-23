#ifndef COMBO_H_
#define COMBO_H_

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_stream.h"

#define W_WIDTH 32
#define I_WIDTH 8
typedef ap_fixed<W_WIDTH,I_WIDTH> interface_t;
typedef ap_fixed<32,8> score_t;

struct DataBus {
    float data;
    bool last;
};

// Prototype of top level function for C-synthesis
void combo_or_i3(
    // Input
    hls::stream<DataBus> &IN1,
    hls::stream<DataBus> &IN2,
    hls::stream<DataBus> &IN3,
    hls::stream<DataBus> &IN4,
    float                threshold,
    // Output
    hls::stream<DataBus> &OUT);

#endif
