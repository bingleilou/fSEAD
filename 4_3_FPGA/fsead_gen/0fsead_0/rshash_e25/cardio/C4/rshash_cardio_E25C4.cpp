#include "rshash_cardio_E25C4.h"
void windower(interface_t data,
            interface_t X0[DIM_MAX],interface_t X1[DIM_MAX],interface_t X2[DIM_MAX],interface_t X3[DIM_MAX],interface_t X4[DIM_MAX],interface_t X5[DIM_MAX],interface_t X6[DIM_MAX],interface_t X7[DIM_MAX],interface_t X8[DIM_MAX],interface_t X9[DIM_MAX],interface_t X10[DIM_MAX],interface_t X11[DIM_MAX],interface_t X12[DIM_MAX],interface_t X13[DIM_MAX],interface_t X14[DIM_MAX],interface_t X15[DIM_MAX],interface_t X16[DIM_MAX],interface_t X17[DIM_MAX],interface_t X18[DIM_MAX],interface_t X19[DIM_MAX],interface_t X20[DIM_MAX],interface_t X21[DIM_MAX],interface_t X22[DIM_MAX],interface_t X23[DIM_MAX],interface_t X24[DIM_MAX],
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
        X20[i] = data_window[i];
        X21[i] = data_window[i];
        X22[i] = data_window[i];
        X23[i] = data_window[i];
        X24[i] = data_window[i];
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
    
void win_idx_upd(uint16_t &wid0, uint16_t &wid1, uint16_t &wid2, uint16_t &wid3, uint16_t &wid4, uint16_t &wid5, uint16_t &wid6, uint16_t &wid7, uint16_t &wid8, uint16_t &wid9, uint16_t &wid10, uint16_t &wid11, uint16_t &wid12, uint16_t &wid13, uint16_t &wid14, uint16_t &wid15, uint16_t &wid16, uint16_t &wid17, uint16_t &wid18, uint16_t &wid19, uint16_t &wid20, uint16_t &wid21, uint16_t &wid22, uint16_t &wid23, uint16_t &wid24) {

    // ****************************************
    // Window index
    // ****************************************
    static uint16_t win_idx = 0;
    win_idx += 1;
    if (win_idx >= BATCH_SIZE){
        win_idx = 0;
    }
    
    wid0 = win_idx;
    wid1 = win_idx;
    wid2 = win_idx;
    wid3 = win_idx;
    wid4 = win_idx;
    wid5 = win_idx;
    wid6 = win_idx;
    wid7 = win_idx;
    wid8 = win_idx;
    wid9 = win_idx;
    wid10 = win_idx;
    wid11 = win_idx;
    wid12 = win_idx;
    wid13 = win_idx;
    wid14 = win_idx;
    wid15 = win_idx;
    wid16 = win_idx;
    wid17 = win_idx;
    wid18 = win_idx;
    wid19 = win_idx;
    wid20 = win_idx;
    wid21 = win_idx;
    wid22 = win_idx;
    wid23 = win_idx;
    wid24 = win_idx;
}


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

void rshash_ensemble(
        interface_t  X0[DIM_MAX],interface_t X1[DIM_MAX],interface_t X2[DIM_MAX],interface_t X3[DIM_MAX],interface_t X4[DIM_MAX],interface_t X5[DIM_MAX],interface_t X6[DIM_MAX],interface_t X7[DIM_MAX],interface_t X8[DIM_MAX],interface_t X9[DIM_MAX],interface_t X10[DIM_MAX],interface_t X11[DIM_MAX],interface_t X12[DIM_MAX],interface_t X13[DIM_MAX],interface_t X14[DIM_MAX],interface_t X15[DIM_MAX],interface_t X16[DIM_MAX],interface_t X17[DIM_MAX],interface_t X18[DIM_MAX],interface_t X19[DIM_MAX],interface_t X20[DIM_MAX],interface_t X21[DIM_MAX],interface_t X22[DIM_MAX],interface_t X23[DIM_MAX],interface_t X24[DIM_MAX],
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
    score_t scores20;
    score_t scores21;
    score_t scores22;
    score_t scores23;
    score_t scores24;
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
    const uint16_t R20= 20;
    const uint16_t R21= 21;
    const uint16_t R22= 22;
    const uint16_t R23= 23;
    const uint16_t R24= 24;
    uint16_t wid0,wid1,wid2,wid3,wid4,wid5,wid6,wid7,wid8,wid9,wid10,wid11,wid12,wid13,wid14,wid15,wid16,wid17,wid18,wid19,wid20,wid21,wid22,wid23,wid24 = 0;
    win_idx_upd(wid0,wid1,wid2,wid3,wid4,wid5,wid6,wid7,wid8,wid9,wid10,wid11,wid12,wid13,wid14,wid15,wid16,wid17,wid18,wid19,wid20,wid21,wid22,wid23,wid24);
    sub_rshash<R0>(X0,   scores0,  wid0);
    sub_rshash<R1>(X1,   scores1,  wid1);
    sub_rshash<R2>(X2,   scores2,  wid2);
    sub_rshash<R3>(X3,   scores3,  wid3);
    sub_rshash<R4>(X4,   scores4,  wid4);
    sub_rshash<R5>(X5,   scores5,  wid5);
    sub_rshash<R6>(X6,   scores6,  wid6);
    sub_rshash<R7>(X7,   scores7,  wid7);
    sub_rshash<R8>(X8,   scores8,  wid8);
    sub_rshash<R9>(X9,   scores9,  wid9);
    sub_rshash<R10>(X10,   scores10,  wid10);
    sub_rshash<R11>(X11,   scores11,  wid11);
    sub_rshash<R12>(X12,   scores12,  wid12);
    sub_rshash<R13>(X13,   scores13,  wid13);
    sub_rshash<R14>(X14,   scores14,  wid14);
    sub_rshash<R15>(X15,   scores15,  wid15);
    sub_rshash<R16>(X16,   scores16,  wid16);
    sub_rshash<R17>(X17,   scores17,  wid17);
    sub_rshash<R18>(X18,   scores18,  wid18);
    sub_rshash<R19>(X19,   scores19,  wid19);
    sub_rshash<R20>(X20,   scores20,  wid20);
    sub_rshash<R21>(X21,   scores21,  wid21);
    sub_rshash<R22>(X22,   scores22,  wid22);
    sub_rshash<R23>(X23,   scores23,  wid23);
    sub_rshash<R24>(X24,   scores24,  wid24);
    score = (scores0+scores1+scores2+scores3+scores4+scores5+scores6+scores7+scores8+scores9+scores10+scores11+scores12+scores13+scores14+scores15+scores16+scores17+scores18+scores19+scores20+scores21+scores22+scores23+scores24);
}

void rshash_cardio_c4(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score
    ){
    #pragma HLS INTERFACE axis register both port=data
    #pragma HLS INTERFACE axis register both port=score
    #pragma HLS INTERFACE s_axilite register port=return

    DataBus_OUT score_out;
    bool flag;

    // Input Conversion
    
    interface_t X0[DIM_MAX],X1[DIM_MAX],X2[DIM_MAX],X3[DIM_MAX],X4[DIM_MAX],X5[DIM_MAX],X6[DIM_MAX],X7[DIM_MAX],X8[DIM_MAX],X9[DIM_MAX],X10[DIM_MAX],X11[DIM_MAX],X12[DIM_MAX],X13[DIM_MAX],X14[DIM_MAX],X15[DIM_MAX],X16[DIM_MAX],X17[DIM_MAX],X18[DIM_MAX],X19[DIM_MAX],X20[DIM_MAX],X21[DIM_MAX],X22[DIM_MAX],X23[DIM_MAX],X24[DIM_MAX];

    DataBus_IN data_X = data.read();
    interface_t data_X_fixed = (interface_t)data_X.data;
    
    windower(data_X_fixed, X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24, flag);
    score_t score_out_fixed, score_out_fixed_r;
    if(flag == 1){
        rshash_ensemble(
                X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,
                score_out_fixed);
        score_out_fixed_r = (score_t)(((accum_t)score_out_fixed*(accum_t)0.04- (accum_t)bottom_rshash)*(accum_t)delta_rshash);

        score_out.data = (float)score_out_fixed_r;
        score_out.last = data_X.last;
        score << score_out;
    }
}
    