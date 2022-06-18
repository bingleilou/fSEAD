

#ifndef RSHASH_GENERATOR_1_H_
#define RSHASH_GENERATOR_1_H_

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
void rshash_cardio(float data);

#define ENSEMBLE 175
#define DIM_MAX 21
#define BATCH_SIZE 128
#define HASH_NUM 2
#define MATRIX_COL 128

typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
#endif