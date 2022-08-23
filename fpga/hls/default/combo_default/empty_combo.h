#ifndef EMPTY_LOGIC_H_
#define EMPTY_LOGIC_H_

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_stream.h"
#include "hls_math.h"

struct DataBus_IN {
    float data;
    ap_uint<1> last;
};

struct DataBus_OUT {
    float data;
    ap_uint<1> last;
};

#define W_WIDTH 32
#define I_WIDTH 16
typedef ap_fixed<W_WIDTH,I_WIDTH> interface_t;

#define DIM_MAX 1

void empty_combo(
    hls::stream<DataBus_IN> &IN1,
	hls::stream<DataBus_IN> &IN2,
	hls::stream<DataBus_IN> &IN3,
	hls::stream<DataBus_IN> &IN4,
    hls::stream<DataBus_OUT> &OUT
    );

#endif
