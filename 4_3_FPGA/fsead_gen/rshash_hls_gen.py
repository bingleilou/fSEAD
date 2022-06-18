import numpy as np
from optparse import OptionParser

optParser = OptionParser()
optParser.add_option('--data_name', action='store',type='string',dest='data_name', default = 'cardio',help='data_name')
(options, args) = optParser.parse_args()
ad         = 'rshash'
data       = options.data_name

clk = 5
ensemble = 25
batch_size = 128
n_bins  = 20

accum_W = 32
accum_I = 16
param_W = 32
param_I = 16
score_W = 32
score_I = 16

if data == 'cardio':
    dim_max = 21
    data_len = 1831
elif data == 'shuttle':
    dim_max = 9
    data_len = 49097
elif data == 'smtp1':
    dim_max = 3
    data_len = 95156
elif data == 'http1':
    dim_max = 3
    data_len = 567498
else:
    print("data name set error, which is: ", data)
    sys.exit()


param_path = "./params/{ad}/{data}/".format(ad=ad,data=data)

M = 7

for m in range(M):
    hls_path = "./0fsead_0/{ad}_e25/{data}/C{c}/".format(ad=ad,data=data,c=m+1)
    ####################################################################
    ########               GENERATE HLS-Test file               ########
    ####################################################################
    f = open(hls_path + 'rshash_'+str(data)+'_E'+str(ensemble)+'C'+str(m+1)+'_test.cpp', "w")
    s='''#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
'''
    f.write(s)
    f.write('#include \"rshash_'+str(data)+'_E'+str(ensemble)+'C'+str(m+1)+'.h\"' + "\n")
    f.write('\n')
    f.write('#define SMAPLE_NUM '+ str(data_len) + '\n')
    f.write('\n')

    s='''
template <class dataType, unsigned int samples, unsigned int window>
int read_file(const char * filename, dataType  **data){
    FILE *fp;
    fp = fopen(filename, \"r\");
    if (fp == 0) {
        return -1;
    }
    // Read data from file
    float newval;
    for (int ii = 0; ii < samples; ii++){
        for (int jj = 0; jj < window-1; jj++) {
            if (fscanf(fp, \"%f,\", &newval) != 0){
                data[ii][jj] = (dataType) newval;
            } else {
                return -2;
            }
        }
        if (fscanf(fp, \"%f\\n\", &newval) != 0){
            data[ii][window-1] = (dataType) newval;
        } else {
            return -2;
        }
    }
    fclose(fp);
    return 0;
}

template <class dataType, unsigned int samples>
int write_file_1D(const char * filename, dataType data[samples]) {
      FILE *fp;
      fp = fopen(filename, \"w\");
      if (fp == 0) {
        return -1;
      }

      // Write data to file
      for (int ii = 0; ii < samples; ii++){
        float newval = (float) data[ii];
        fprintf(fp, \"%f\\n\", newval);
       }
       fclose(fp);
       return 0;
}



int main(int argc, char **argv)
{
    int rval = 0;
    
    interface_t  **X;
    X = (interface_t **)malloc(sizeof(interface_t *) * SMAPLE_NUM);
    for (int i = 0; i<SMAPLE_NUM; i ++) {
        X[i] = (interface_t *)malloc(sizeof(interface_t) * DIM_MAX);
    }

    interface_t *y;
    y = (interface_t *)malloc(sizeof(interface_t) * SMAPLE_NUM);
    float *tb_score_rshash;
    tb_score_rshash = (float *)malloc(sizeof(float) * SMAPLE_NUM);
'''
    f.write(s)
    f.write('    rval = read_file<interface_t, SMAPLE_NUM, DIM_MAX>(\"data/'+str(data)+'_X\", X);\n')
    s='''
    for (int isample=0; isample < SMAPLE_NUM; isample++) {
        hls::stream<DataBus_OUT> score_rshash;
        for (int idim=0; idim < DIM_MAX; idim++) {
            hls::stream<DataBus_IN> data_str;
            DataBus_IN data_str_bus;
            data_str_bus.data = X[isample][idim];
            if(isample == SMAPLE_NUM-1){
                data_str_bus.last = 1;
            }else{
                data_str_bus.last = 0;
            }
            data_str << data_str_bus;
    '''
    f.write(s)
    
    f.write('            rshash_'+str(data)+'_c'+str(m+1)+'(data_str, score_rshash);'+'\n')
    s='''
        }

        interface_t score_stream_rshash;
        DataBus_OUT score_rshash_bus;
        score_rshash_bus= score_rshash.read();
        score_stream_rshash = score_rshash_bus.data;
        tb_score_rshash[isample] = score_stream_rshash;
    }
'''
    f.write(s)
    f.write('    rval = write_file_1D<float, SMAPLE_NUM>("D:/HLS/0fsead_0/rshash_e25/'+str(data)+'/C'+str(m+1)+'/data/score_rshash_'+str(data)+'\", tb_score_rshash);\n')
    f.write('}')
    
    ####################################################################
    ########                 GENERATE GCC-C file                ########
    ####################################################################
    f = open(hls_path + 'rshash_'+str(data)+'_E'+str(ensemble)+'C'+str(m+1)+'.cpp', "w")
    f.write('#include \"rshash_'+str(data)+'_E'+str(ensemble)+'C'+str(m+1)+'.h\"' + "\n")
    
    ####################################     windower
    f.write("void windower(interface_t data," + "\n")
    f.write("            interface_t X0[DIM_MAX],")
    for j in range(ensemble-1):
        if j > 0:
            f.write('interface_t X'+str(j)+'[DIM_MAX],')
    f.write('interface_t X'+str(ensemble-1)+'[DIM_MAX],'+ "\n")
    f.write("            bool &finish_1_sample_flag){"+ "\n")
    f.write("    #pragma HLS inline"+ "\n")
    s = '''
    static interface_t data_window [DIM_MAX] = {0};
    static uint16_t count = 0;
    #pragma HLS ARRAY_PARTITION variable=data_window complete dim=1

    finish_1_sample_flag = 0;
    count += 1;
    if (count == DIM_MAX){
        count = 0;
        finish_1_sample_flag = 1;
    }

    LOOP_STATIC_DATA_WINDOWS:for (uint16_t i = 0; i < DIM_MAX-1; i++) {
        #pragma HLS UNROLL
        data_window[i] = data_window[i+1];

    }
    data_window[DIM_MAX-1] = (interface_t)data;

    LOOP_OUTPUT_DATA_WINDOWS:for (uint16_t i = 0 ; i < DIM_MAX; i++) {
        #pragma HLS UNROLL
    '''
    f.write(s)
    f.write('\n')
    for j in range(ensemble):
        f.write('        X'+str(j)+'[i] = data_window[i];'+ "\n")
    f.write("    }"+ "\n")
    f.write("}"+ "\n")
    f.write('\n')

    ####################################     jenkins_hash_hls
    s='''
template<uint16_t DIM>
void jenkins_hash_hls(char_t key[DIM], uint16_t len, uint32_t seed, uint16_t &hash_code){
    uint32_t hash = seed;
    for(uint16_t i = 0; i < len; i++){
        #pragma HLS PIPELINE II=1
        hash += (uint32_t)key[i];
        hash += hash << 10;
        hash ^= hash >> 6;
    }
    hash += hash << 3;
    hash ^= hash >> 11;
    hash += hash << 15;
    hash_code = (uint16_t)(hash % uint32_t(MATRIX_COL));
}
    '''
    f.write(s)
    f.write('\n')
    
    ####################################     hash_dataflow
    s='''
template<uint16_t DIM>
void hash_dataflow(char_t key[HASH_NUM][DIM], uint16_t len, uint16_t hash_code[HASH_NUM]){
    #pragma HLS DATAFLOW
    jenkins_hash_hls<DIM>(key[0], len, (uint32_t)0, hash_code[0]);
    jenkins_hash_hls<DIM>(key[1], len, (uint32_t)1, hash_code[1]);
}
    '''
    f.write(s)
    f.write('\n')
    
    
    ####################################     min_hash
    s='''
template<uint16_t DIM>
void min_hash(uint16_t data[DIM], uint16_t &min_value) {
    #pragma HLS inline
    uint16_t temp = data[0];
    for (uint16_t i = 0 ; i < DIM; i++) {
        #pragma HLS PIPELINE
        if (data[i]<temp){
            temp = data[i];
        }
    }
    min_value = temp;
}
    '''
    f.write(s)
    f.write('\n')
    
    
    ####################################     win_idx_upd
    f.write("void win_idx_upd(")
    for j in range(ensemble-1):
        f.write('uint16_t &wid'+str(j)+', ')
    f.write('uint16_t &wid'+str(ensemble-1)+') {\n')
    s = '''
    // ****************************************
    // Window index
    // ****************************************
    static uint16_t win_idx = 0;
    win_idx += 1;
    if (win_idx >= BATCH_SIZE){
        win_idx = 0;
    }
    '''
    f.write(s)
    f.write('\n')
    for j in range(ensemble):
        f.write('    wid'+str(j)+' = win_idx;'+ "\n")
    f.write("}"+ "\n")
    f.write('\n')
    
    ####################################     sub_rshash
    s='''
template<uint16_t r>
void sub_rshash(interface_t X[DIM_MAX],
        score_t &score,
        uint16_t win_idx
        ) {
    static uint16_t windows_value[HASH_NUM][BATCH_SIZE] = {0};
    static uint16_t windows_num[HASH_NUM][BATCH_SIZE] = {0};
    static uint16_t V_c[HASH_NUM][BATCH_SIZE] = {0};
    static uint16_t N_c[HASH_NUM] = {0};

    #pragma HLS ARRAY_PARTITION variable=windows_value    complete dim=1
    #pragma HLS ARRAY_PARTITION variable=windows_num      complete dim=1
    #pragma HLS ARRAY_PARTITION variable=V_c              complete dim=1
    #pragma HLS ARRAY_PARTITION variable=N_c              complete dim=1

    #pragma HLS ARRAY_PARTITION variable=log_LUT_rshash   complete dim=1
    #pragma HLS ARRAY_PARTITION variable=rshash_f         complete dim=1
    #pragma HLS ARRAY_PARTITION variable=rshash_alpha     complete dim=1

    char_t projected_X8_hash[HASH_NUM][DIM_MAX];
    #pragma HLS ARRAY_PARTITION variable=projected_X8_hash    complete dim=1
    // ****************************************
    // Random Projection
    // ****************************************
    Project_LOOP_Dim: for(uint16_t dim = 0; dim < DIM_MAX; dim++) {
        #pragma HLS PIPELINE II=1
        param_t X_norm = (X[dim] - rshash_min_X[dim])*rshash_delta_X[dim];
        char_t projected_X_8 = (char_t)((X_norm + rshash_alpha[r][dim])*rshash_f[r]);
        for(uint16_t row = 0; row < HASH_NUM; row++) {
            #pragma HLS UNROLL
            projected_X8_hash[row][dim] = projected_X_8;
        }
    }

    uint16_t value[HASH_NUM];
    #pragma HLS ARRAY_PARTITION variable=value            complete dim=1

    hash_dataflow<DIM_MAX>(projected_X8_hash, (uint16_t)DIM_MAX, value);

    uint16_t VC_table[HASH_NUM];
    uint16_t NC_table[HASH_NUM];
    #pragma HLS ARRAY_PARTITION variable=VC_table    complete dim=1
    #pragma HLS ARRAY_PARTITION variable=NC_table    complete dim=1
    CMS_LOOP: for(uint16_t row = 0; row < HASH_NUM; row++) {
        #pragma HLS UNROLL
        uint16_t VC_value;
        uint16_t NC_value;
        // ****************************************
        // Slide Windows
        // ****************************************
        uint16_t valueFromWin;
        uint16_t nFromWin;
        VC_value = V_c[row][value[row]];
        NC_value = N_c[row];

        V_c[row][value[row]] += 1;
        N_c[row] += 1;

        valueFromWin = windows_value[row][win_idx];
        nFromWin = windows_num[row][win_idx];

        V_c[row][valueFromWin] -= nFromWin;
        N_c[row] -= nFromWin;

        windows_value[row][win_idx] = value[row];
        windows_num[row][win_idx] = 1;

        VC_table[row] = VC_value;
        NC_table[row] = NC_value;
    }
    uint16_t min_c;
    min_hash<HASH_NUM>(VC_table, min_c);

    if(min_c > BATCH_SIZE-1){min_c = BATCH_SIZE-1;}
    else if(min_c < 0){min_c = 0;}
    else{min_c = min_c;}
    
    score = (score_t)log_LUT_rshash[min_c];
}
'''
    f.write(s)
    f.write('\n')
    
    ####################################     rshash_ensemble
    f.write("void rshash_ensemble(" + "\n")
    f.write("        interface_t  X0[DIM_MAX],")
    for j in range(ensemble-1):
        if j > 0:
            f.write('interface_t X'+str(j)+'[DIM_MAX],')
    f.write('interface_t X'+str(ensemble-1)+'[DIM_MAX],'+ "\n")
    f.write("        score_t &score"+ "\n")
    f.write("        ) {"+ "\n")
    f.write("    #pragma HLS DATAFLOW"+ "\n")

    for j in range(ensemble):
        f.write('    score_t scores'+str(j)+";\n")

    for j in range(ensemble):
        f.write('    const uint16_t R'+str(j)+"= " +str(j) +";\n")

    f.write('    uint16_t ')
    for j in range(ensemble-1):
        f.write('wid'+str(j)+",")
    f.write('wid'+str(ensemble-1)+" = 0;\n")

    f.write('    win_idx_upd(')
    for j in range(ensemble-1):
        f.write('wid'+str(j)+",")
    f.write('wid'+str(ensemble-1)+");\n")

    for j in range(ensemble):
        f.write('    sub_rshash<R'+str(j)+'>(X'+str(j)+',   scores'+str(j)+',  wid'+ str(j)+");\n")

    f.write('    score = (')
    for j in range(ensemble-1):
        f.write('scores'+str(j)+"+")
    f.write('scores'+str(ensemble-1)+");\n")
    f.write('}\n')
    f.write('\n')
    
    ####################################     rshash_cardio
    f.write('void rshash_'+str(data)+'_c'+str(m+1)+'(')
    s = '''
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score
    ){
    #pragma HLS INTERFACE axis register both port=data
    #pragma HLS INTERFACE axis register both port=score
    #pragma HLS INTERFACE s_axilite register port=return

    DataBus_OUT score_out;
    bool flag;

    // Input Conversion
    '''
    f.write(s)
    f.write('\n')
    f.write("    interface_t ")
    for j in range(ensemble-1):
        f.write('X'+str(j)+'[DIM_MAX],')
    f.write('X'+str(ensemble-1)+'[DIM_MAX];'+ "\n")

    s='''
    DataBus_IN data_X = data.read();
    interface_t data_X_fixed = (interface_t)data_X.data;
    '''
    f.write(s)
    f.write('\n')
    f.write("    windower(data_X_fixed, ")
    for j in range(ensemble-1):
        f.write('X'+str(j)+',')
    f.write('X'+str(ensemble-1)+', flag);'+ "\n")
    f.write("    score_t score_out_fixed, score_out_fixed_r;\n")
    f.write("    if(flag == 1){\n")
    f.write("        rshash_ensemble(\n")
    f.write("                ")
    for j in range(ensemble-1):
        f.write('X'+str(j)+',')
    f.write('X'+str(ensemble-1)+ ",\n")
    f.write("                score_out_fixed);\n")


    f.write('        score_out_fixed_r = (score_t)(((accum_t)score_out_fixed*(accum_t)'+str(1/ensemble)+'- (accum_t)bottom_rshash)*(accum_t)delta_rshash);\n')
    s='''
        score_out.data = (float)score_out_fixed_r;
        score_out.last = data_X.last;
        score << score_out;
    }
}
    '''
    f.write(s)

    ####################################################################
    ########                 GENERATE GCC-H file                ########
    ####################################################################
    f = open(hls_path + 'rshash_'+str(data)+'_E'+str(ensemble)+'C'+str(m+1)+'.h', "w")
    s='''#ifndef RSHASH_GENERATOR_1_H_
#define RSHASH_GENERATOR_1_H_

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_stream.h"
#include "hls_math.h"
#define W_WIDTH 32
#define I_WIDTH 16
typedef ap_fixed<W_WIDTH,I_WIDTH> interface_t;
    '''
    f.write(s)
    f.write('\n')
    f.write('typedef ap_fixed<'+str(accum_W)+','+str(accum_I)+'> accum_t;\n')
    f.write('typedef ap_fixed<'+str(param_W)+','+str(param_I)+'> param_t;\n')
    f.write('typedef ap_fixed<'+str(score_W)+','+str(score_I)+'> score_t;\n')
    f.write('typedef ap_uint<'+str(16)+'> const_t;\n')
    f.write('typedef ap_uint<'+str(8)+'> char_t;\n')
    s='''
struct DataBus_IN {
    float data;
    ap_uint<1> last;
};

struct DataBus_OUT {
    float data;
    ap_uint<1> last;
};
    '''
    f.write(s)
    f.write('\n')
    f.write('void rshash_'+str(data)+'_c'+str(m+1)+'(')
    s='''
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_rshash
);
    '''
    f.write(s)
    f.write('\n')

    f_params = open(param_path + 'params_rshash'+'_E'+str(ensemble)+'C'+str(m+1)+'.h', "r")
    ss = f_params.read()
    f.write(ss)

    f.write('#endif')


    ####################################################################
    ########               GENERATE hls_prj.tcl                 ########
    ####################################################################
    f = open(hls_path + 'hls_prj.tcl', "w")
    f.write('set data_name '+str(data)+'\n')
    f.write('open_project -reset hls_rshash_${data_name}_prj'+'\n')
    f.write('set_top '+str(ad)+'_'+str(data)+'_c'+str(m+1)+'\n')
    f.write('add_files '+'rshash_'+str(data)+'_E'+str(ensemble)+'C'+str(m+1)+'.cpp\n')
    f.write('add_files -tb '+'rshash_'+str(data)+'_E'+str(ensemble)+'C'+str(m+1)+'_test.cpp\n')
    
    s='''
add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    '''
    f.write(s)
    f.write('\n')
    f.write('create_clock -period '+str(clk)+' -name default\n')
    f.write('# csim_design -clean\n')
    f.write('csynth_design\n')
    f.write('# cosim_design\n')
    f.write('export_design -format ip_catalog\n')
    f.write('exit')
    
    ####################################################################
    ########                 GENERATE Makefile                  ########
    ####################################################################
    f = open(hls_path + 'Makefile', "w")
    s='''all:
	vivado_hls hls_prj.tcl -f
hls:
	vivado_hls hls_prj.tcl -f
clean:
	rm -rf *.log *.jou .Xil hls_rshash_*_prj/ vivado_rshash_*_prj/
    '''
    f.write(s)