

#ifndef XSTREAM_GENERATOR_1_H_
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

// Prototype of top level function for C-synthesis
void xstream_cardio(float data);

#define ENSEMBLE 140
#define DIM_MAX 3
#define BATCH_SIZE 128
#define K_NUM 20
#define HASH_NUM 2
#define MATRIX_COL 128

typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
#endif