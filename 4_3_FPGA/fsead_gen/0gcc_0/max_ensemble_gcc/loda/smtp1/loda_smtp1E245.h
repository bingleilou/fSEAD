

#ifndef LODA_GENERATOR_1_H_
#define LODA_GENERATOR_1_H_

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
void loda_cardio(float data);

#define ENSEMBLE 245
#define DIM_MAX 3
#define BATCH_SIZE 128
#define N_BINS 20
#endif