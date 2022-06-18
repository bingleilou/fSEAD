#include "xstream_http1_E20C2.h"
void windower(interface_t data,
            interface_t X0[DIM_MAX],interface_t X1[DIM_MAX],interface_t X2[DIM_MAX],interface_t X3[DIM_MAX],interface_t X4[DIM_MAX],interface_t X5[DIM_MAX],interface_t X6[DIM_MAX],interface_t X7[DIM_MAX],interface_t X8[DIM_MAX],interface_t X9[DIM_MAX],interface_t X10[DIM_MAX],interface_t X11[DIM_MAX],interface_t X12[DIM_MAX],interface_t X13[DIM_MAX],interface_t X14[DIM_MAX],interface_t X15[DIM_MAX],interface_t X16[DIM_MAX],interface_t X17[DIM_MAX],interface_t X18[DIM_MAX],interface_t X19[DIM_MAX],
            bool &finish_1_sample_flag){
    #pragma HLS inline

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
    
        X0[i] = data_window[i];
        X1[i] = data_window[i];
        X2[i] = data_window[i];
        X3[i] = data_window[i];
        X4[i] = data_window[i];
        X5[i] = data_window[i];
        X6[i] = data_window[i];
        X7[i] = data_window[i];
        X8[i] = data_window[i];
        X9[i] = data_window[i];
        X10[i] = data_window[i];
        X11[i] = data_window[i];
        X12[i] = data_window[i];
        X13[i] = data_window[i];
        X14[i] = data_window[i];
        X15[i] = data_window[i];
        X16[i] = data_window[i];
        X17[i] = data_window[i];
        X18[i] = data_window[i];
        X19[i] = data_window[i];
    }
}


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
    

template<uint16_t DIM>
void hash_dataflow(char_t key[HASH_NUM][DIM], uint16_t len, uint16_t hash_code[HASH_NUM]){
    #pragma HLS DATAFLOW
    jenkins_hash_hls<DIM>(key[0], len, (uint32_t)0, hash_code[0]);
    jenkins_hash_hls<DIM>(key[1], len, (uint32_t)1, hash_code[1]);
}
    

template<uint16_t DIM>
void min_score(score_t data[DIM], score_t &min_value) {
    score_t temp = data[0];
    for (uint16_t i = 0 ; i < DIM; i++) {
        #pragma HLS PIPELINE
        if (data[i]<temp){
            temp = data[i];
        }
    }
    min_value = temp;
}
    

void win_idx_upd(uint16_t &wid0) {
    // ****************************************
    // Window index
    // ****************************************
    static uint16_t win_idx = 0;
    win_idx += 1;
    if (win_idx >= BATCH_SIZE){
        win_idx = 0;
    }
    wid0 = win_idx;

}
    

template<uint16_t r>
void sub_xstream(interface_t X[DIM_MAX],
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
    #pragma HLS ARRAY_PARTITION variable=log_LUT_xstream_d0  complete dim=1
	#pragma HLS ARRAY_PARTITION variable=xstream_fs                complete dim=1
	#pragma HLS ARRAY_PARTITION variable=xstream_shift             complete dim=1
    #pragma HLS ARRAY_PARTITION variable=xstream_shift_deltamax    complete dim=1

    char_t perbins_hash[HASH_NUM][K_NUM];
    #pragma HLS ARRAY_PARTITION variable=perbins_hash    complete dim=1

    accum_t perbins[K_NUM];
    uint16_t depthcount[K_NUM];
    #pragma HLS ARRAY_PARTITION variable=perbins          complete dim=1
    #pragma HLS ARRAY_PARTITION variable=depthcount       complete dim=1
    // ****************************************
    // Random Projection
    // ****************************************
    accum_t Y_c[K_NUM] = {0};
    #pragma HLS ARRAY_PARTITION variable=Y_c                complete dim=1

    #pragma HLS ARRAY_PARTITION variable=xstream_R_T_prj    complete dim=2

    Init_LOOP:for(uint16_t k = 0; k < K_NUM; k++) {
        #pragma HLS UNROLL
        Y_c[k] = 0;
        perbins[k] = 0;
        perbins_hash[0][k] = 0;
        perbins_hash[1][k] = 0;
        depthcount[k] = 0;
    }

    NewInput: for(uint16_t dim = 0; dim < DIM_MAX; dim++) {
        #pragma HLS PIPELINE II=1
        Product: for(uint16_t kk = 0; kk < K_NUM; kk++) {
            #pragma HLS UNROLL
            Y_c[kk] += (accum_t)X[dim] * (accum_t)xstream_R_T[dim][kk];
        }
    }

    HASH_LOOP: for(uint16_t row = 0; row < HASH_NUM; row++) {
        #pragma HLS UNROLL
        uint16_t  f = (uint16_t)xstream_fs[r][row];
        depthcount[f] += 1;
        if(depthcount[f]==1){
            perbins[f] = (accum_t)((Y_c[f]+xstream_shift[r][f])*xstream_deltamax[f]);
        }else{
            perbins[f] = perbins[f] + perbins[f] + (accum_t)xstream_shift_deltamax[r][f];
        }
        perbins_hash[row][f] =  (char_t)(hls::floor(perbins[f]));
    }

    uint16_t value[HASH_NUM];
    #pragma HLS ARRAY_PARTITION variable=value            complete dim=1

    hash_dataflow<K_NUM>(perbins_hash, (uint16_t)K_NUM, value);

    score_t score_hash[HASH_NUM];
    #pragma HLS ARRAY_PARTITION variable=score_hash    complete dim=1
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

        if(VC_value > BATCH_SIZE-1){
            VC_value = BATCH_SIZE-1;
        }else if(VC_value < 0){
            VC_value = 0;
        }else{
            VC_value = VC_value;
        }
        score_hash[row] = (score_t)log_LUT_xstream_d0[VC_value] + (score_t)row;
    }
    score_t c=0;
    min_score<HASH_NUM>(score_hash, c);
    score = -c;
}

void xstream_ensemble(
        interface_t  X0[DIM_MAX],interface_t X1[DIM_MAX],interface_t X2[DIM_MAX],interface_t X3[DIM_MAX],interface_t X4[DIM_MAX],interface_t X5[DIM_MAX],interface_t X6[DIM_MAX],interface_t X7[DIM_MAX],interface_t X8[DIM_MAX],interface_t X9[DIM_MAX],interface_t X10[DIM_MAX],interface_t X11[DIM_MAX],interface_t X12[DIM_MAX],interface_t X13[DIM_MAX],interface_t X14[DIM_MAX],interface_t X15[DIM_MAX],interface_t X16[DIM_MAX],interface_t X17[DIM_MAX],interface_t X18[DIM_MAX],interface_t X19[DIM_MAX],
        score_t &score
        ) {
    #pragma HLS DATAFLOW
    score_t scores0;
    score_t scores1;
    score_t scores2;
    score_t scores3;
    score_t scores4;
    score_t scores5;
    score_t scores6;
    score_t scores7;
    score_t scores8;
    score_t scores9;
    score_t scores10;
    score_t scores11;
    score_t scores12;
    score_t scores13;
    score_t scores14;
    score_t scores15;
    score_t scores16;
    score_t scores17;
    score_t scores18;
    score_t scores19;
    const uint16_t R0= 0;
    const uint16_t R1= 1;
    const uint16_t R2= 2;
    const uint16_t R3= 3;
    const uint16_t R4= 4;
    const uint16_t R5= 5;
    const uint16_t R6= 6;
    const uint16_t R7= 7;
    const uint16_t R8= 8;
    const uint16_t R9= 9;
    const uint16_t R10= 10;
    const uint16_t R11= 11;
    const uint16_t R12= 12;
    const uint16_t R13= 13;
    const uint16_t R14= 14;
    const uint16_t R15= 15;
    const uint16_t R16= 16;
    const uint16_t R17= 17;
    const uint16_t R18= 18;
    const uint16_t R19= 19;
    uint16_t  wid0 = 0;
    win_idx_upd(wid0);
    sub_xstream<R0>(X0,   scores0,  wid0);
    sub_xstream<R1>(X1,   scores1,  wid0);
    sub_xstream<R2>(X2,   scores2,  wid0);
    sub_xstream<R3>(X3,   scores3,  wid0);
    sub_xstream<R4>(X4,   scores4,  wid0);
    sub_xstream<R5>(X5,   scores5,  wid0);
    sub_xstream<R6>(X6,   scores6,  wid0);
    sub_xstream<R7>(X7,   scores7,  wid0);
    sub_xstream<R8>(X8,   scores8,  wid0);
    sub_xstream<R9>(X9,   scores9,  wid0);
    sub_xstream<R10>(X10,   scores10,  wid0);
    sub_xstream<R11>(X11,   scores11,  wid0);
    sub_xstream<R12>(X12,   scores12,  wid0);
    sub_xstream<R13>(X13,   scores13,  wid0);
    sub_xstream<R14>(X14,   scores14,  wid0);
    sub_xstream<R15>(X15,   scores15,  wid0);
    sub_xstream<R16>(X16,   scores16,  wid0);
    sub_xstream<R17>(X17,   scores17,  wid0);
    sub_xstream<R18>(X18,   scores18,  wid0);
    sub_xstream<R19>(X19,   scores19,  wid0);
    score = (scores0+scores1+scores2+scores3+scores4+scores5+scores6+scores7+scores8+scores9+scores10+scores11+scores12+scores13+scores14+scores15+scores16+scores17+scores18+scores19);
}

void xstream_http1_c2(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score
    ){
    #pragma HLS INTERFACE axis register both port=data
    #pragma HLS INTERFACE axis register both port=score
    #pragma HLS INTERFACE s_axilite register port=return

    DataBus_OUT score_out;
    bool flag;

    // Input Conversion
    
    interface_t X0[DIM_MAX],X1[DIM_MAX],X2[DIM_MAX],X3[DIM_MAX],X4[DIM_MAX],X5[DIM_MAX],X6[DIM_MAX],X7[DIM_MAX],X8[DIM_MAX],X9[DIM_MAX],X10[DIM_MAX],X11[DIM_MAX],X12[DIM_MAX],X13[DIM_MAX],X14[DIM_MAX],X15[DIM_MAX],X16[DIM_MAX],X17[DIM_MAX],X18[DIM_MAX],X19[DIM_MAX];

    DataBus_IN data_X = data.read();
    interface_t data_X_fixed = (interface_t)data_X.data;
    
    windower(data_X_fixed, X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19, flag);
    score_t score_out_fixed, score_out_fixed_r;
    if(flag == 1){
        xstream_ensemble(
                X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,
                score_out_fixed);
        score_out_fixed_r = (score_t)(((accum_t)score_out_fixed*(accum_t)0.05- (accum_t)bottom_xstream)*(accum_t)delta_xstream);

        score_out.data = (float)score_out_fixed_r;
        score_out.last = data_X.last;
        score << score_out;
    }
}
    