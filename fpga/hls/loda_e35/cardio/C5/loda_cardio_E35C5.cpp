#include "loda_cardio_E35C5.h"
void windower(interface_t data,
            interface_t X0[DIM_MAX],interface_t X1[DIM_MAX],interface_t X2[DIM_MAX],interface_t X3[DIM_MAX],interface_t X4[DIM_MAX],interface_t X5[DIM_MAX],interface_t X6[DIM_MAX],interface_t X7[DIM_MAX],interface_t X8[DIM_MAX],interface_t X9[DIM_MAX],interface_t X10[DIM_MAX],interface_t X11[DIM_MAX],interface_t X12[DIM_MAX],interface_t X13[DIM_MAX],interface_t X14[DIM_MAX],interface_t X15[DIM_MAX],interface_t X16[DIM_MAX],interface_t X17[DIM_MAX],interface_t X18[DIM_MAX],interface_t X19[DIM_MAX],interface_t X20[DIM_MAX],interface_t X21[DIM_MAX],interface_t X22[DIM_MAX],interface_t X23[DIM_MAX],interface_t X24[DIM_MAX],interface_t X25[DIM_MAX],interface_t X26[DIM_MAX],interface_t X27[DIM_MAX],interface_t X28[DIM_MAX],interface_t X29[DIM_MAX],interface_t X30[DIM_MAX],interface_t X31[DIM_MAX],interface_t X32[DIM_MAX],interface_t X33[DIM_MAX],interface_t X34[DIM_MAX],
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
        X25[i] = data_window[i];
        X26[i] = data_window[i];
        X27[i] = data_window[i];
        X28[i] = data_window[i];
        X29[i] = data_window[i];
        X30[i] = data_window[i];
        X31[i] = data_window[i];
        X32[i] = data_window[i];
        X33[i] = data_window[i];
        X34[i] = data_window[i];
    }
}

void win_idx_upd(uint16_t &wid0, uint16_t &wid1, uint16_t &wid2, uint16_t &wid3, uint16_t &wid4, uint16_t &wid5, uint16_t &wid6, uint16_t &wid7, uint16_t &wid8, uint16_t &wid9, uint16_t &wid10, uint16_t &wid11, uint16_t &wid12, uint16_t &wid13, uint16_t &wid14, uint16_t &wid15, uint16_t &wid16, uint16_t &wid17, uint16_t &wid18, uint16_t &wid19, uint16_t &wid20, uint16_t &wid21, uint16_t &wid22, uint16_t &wid23, uint16_t &wid24, uint16_t &wid25, uint16_t &wid26, uint16_t &wid27, uint16_t &wid28, uint16_t &wid29, uint16_t &wid30, uint16_t &wid31, uint16_t &wid32, uint16_t &wid33, uint16_t &wid34) {

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
    wid25 = win_idx;
    wid26 = win_idx;
    wid27 = win_idx;
    wid28 = win_idx;
    wid29 = win_idx;
    wid30 = win_idx;
    wid31 = win_idx;
    wid32 = win_idx;
    wid33 = win_idx;
    wid34 = win_idx;
}


template<uint16_t r>
void sub_loda(interface_t X[DIM_MAX],
        score_t &score,
        uint16_t win_idx
        ) {

    static uint16_t windows_value[BATCH_SIZE] = {0};
    static uint16_t windows_num[BATCH_SIZE] = {0};
    static uint16_t V_c[BATCH_SIZE] = {0};
    static uint16_t N_c = 0;

    #pragma HLS ARRAY_PARTITION variable=loda_projections    complete dim=1
    #pragma HLS ARRAY_PARTITION variable=loda_min_X          complete dim=1
    #pragma HLS ARRAY_PARTITION variable=loda_delta          complete dim=1
    #pragma HLS ARRAY_PARTITION variable=log_LUT_loda        complete dim=0
    // ****************************************
    // Random Projection
    // ****************************************
    accum_t projected_X_temp = 0;
    Project_LOOP_Dim: for(uint16_t dim = 0; dim < DIM_MAX; dim++) {
        #pragma HLS PIPELINE
        projected_X_temp += X[dim] * loda_projections[r][dim];
    }

    uint16_t idx_temp = 0;
    uint16_t VC_table;
    uint16_t NC_table;
    uint16_t value = 0;

    idx_temp = (uint16_t)((projected_X_temp - (accum_t)loda_min_X[r])*(accum_t)loda_delta[r]);
    if (idx_temp >= N_BINS){
        idx_temp = N_BINS - 1;
    }
    if (idx_temp <= 0){
        idx_temp = 0;
    }
    value = idx_temp;

    uint16_t VC_value;
    uint16_t NC_value;
    // ****************************************
    // Slide Windows
    // ****************************************
    uint16_t valueFromWin;
    uint16_t nFromWin;

    VC_value = V_c[value];
    NC_value = N_c;

    V_c[value] += 1;
    N_c += 1;

    valueFromWin = windows_value[win_idx];
    nFromWin = windows_num[win_idx];

    V_c[valueFromWin] -= nFromWin;
    N_c -= nFromWin;

    windows_value[win_idx] = value;
    windows_num[win_idx] = 1;

    VC_table = VC_value;
    NC_table = NC_value;
    
    if(VC_table > BATCH_SIZE - 1){
        VC_table = BATCH_SIZE - 1;
    }
    else if(VC_table < 0){
        VC_table = 0;
    }else{
        VC_table = VC_table;
    }
    score = (score_t)log_LUT_loda[VC_table];
}
void loda_ensemble(
        interface_t  X0[DIM_MAX],interface_t X1[DIM_MAX],interface_t X2[DIM_MAX],interface_t X3[DIM_MAX],interface_t X4[DIM_MAX],interface_t X5[DIM_MAX],interface_t X6[DIM_MAX],interface_t X7[DIM_MAX],interface_t X8[DIM_MAX],interface_t X9[DIM_MAX],interface_t X10[DIM_MAX],interface_t X11[DIM_MAX],interface_t X12[DIM_MAX],interface_t X13[DIM_MAX],interface_t X14[DIM_MAX],interface_t X15[DIM_MAX],interface_t X16[DIM_MAX],interface_t X17[DIM_MAX],interface_t X18[DIM_MAX],interface_t X19[DIM_MAX],interface_t X20[DIM_MAX],interface_t X21[DIM_MAX],interface_t X22[DIM_MAX],interface_t X23[DIM_MAX],interface_t X24[DIM_MAX],interface_t X25[DIM_MAX],interface_t X26[DIM_MAX],interface_t X27[DIM_MAX],interface_t X28[DIM_MAX],interface_t X29[DIM_MAX],interface_t X30[DIM_MAX],interface_t X31[DIM_MAX],interface_t X32[DIM_MAX],interface_t X33[DIM_MAX],interface_t X34[DIM_MAX],
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
    score_t scores25;
    score_t scores26;
    score_t scores27;
    score_t scores28;
    score_t scores29;
    score_t scores30;
    score_t scores31;
    score_t scores32;
    score_t scores33;
    score_t scores34;
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
    const uint16_t R25= 25;
    const uint16_t R26= 26;
    const uint16_t R27= 27;
    const uint16_t R28= 28;
    const uint16_t R29= 29;
    const uint16_t R30= 30;
    const uint16_t R31= 31;
    const uint16_t R32= 32;
    const uint16_t R33= 33;
    const uint16_t R34= 34;
    uint16_t wid0,wid1,wid2,wid3,wid4,wid5,wid6,wid7,wid8,wid9,wid10,wid11,wid12,wid13,wid14,wid15,wid16,wid17,wid18,wid19,wid20,wid21,wid22,wid23,wid24,wid25,wid26,wid27,wid28,wid29,wid30,wid31,wid32,wid33,wid34 = 0;
    win_idx_upd(wid0,wid1,wid2,wid3,wid4,wid5,wid6,wid7,wid8,wid9,wid10,wid11,wid12,wid13,wid14,wid15,wid16,wid17,wid18,wid19,wid20,wid21,wid22,wid23,wid24,wid25,wid26,wid27,wid28,wid29,wid30,wid31,wid32,wid33,wid34);
    sub_loda<R0>(X0,   scores0,  wid0);
    sub_loda<R1>(X1,   scores1,  wid1);
    sub_loda<R2>(X2,   scores2,  wid2);
    sub_loda<R3>(X3,   scores3,  wid3);
    sub_loda<R4>(X4,   scores4,  wid4);
    sub_loda<R5>(X5,   scores5,  wid5);
    sub_loda<R6>(X6,   scores6,  wid6);
    sub_loda<R7>(X7,   scores7,  wid7);
    sub_loda<R8>(X8,   scores8,  wid8);
    sub_loda<R9>(X9,   scores9,  wid9);
    sub_loda<R10>(X10,   scores10,  wid10);
    sub_loda<R11>(X11,   scores11,  wid11);
    sub_loda<R12>(X12,   scores12,  wid12);
    sub_loda<R13>(X13,   scores13,  wid13);
    sub_loda<R14>(X14,   scores14,  wid14);
    sub_loda<R15>(X15,   scores15,  wid15);
    sub_loda<R16>(X16,   scores16,  wid16);
    sub_loda<R17>(X17,   scores17,  wid17);
    sub_loda<R18>(X18,   scores18,  wid18);
    sub_loda<R19>(X19,   scores19,  wid19);
    sub_loda<R20>(X20,   scores20,  wid20);
    sub_loda<R21>(X21,   scores21,  wid21);
    sub_loda<R22>(X22,   scores22,  wid22);
    sub_loda<R23>(X23,   scores23,  wid23);
    sub_loda<R24>(X24,   scores24,  wid24);
    sub_loda<R25>(X25,   scores25,  wid25);
    sub_loda<R26>(X26,   scores26,  wid26);
    sub_loda<R27>(X27,   scores27,  wid27);
    sub_loda<R28>(X28,   scores28,  wid28);
    sub_loda<R29>(X29,   scores29,  wid29);
    sub_loda<R30>(X30,   scores30,  wid30);
    sub_loda<R31>(X31,   scores31,  wid31);
    sub_loda<R32>(X32,   scores32,  wid32);
    sub_loda<R33>(X33,   scores33,  wid33);
    sub_loda<R34>(X34,   scores34,  wid34);
    score = (scores0+scores1+scores2+scores3+scores4+scores5+scores6+scores7+scores8+scores9+scores10+scores11+scores12+scores13+scores14+scores15+scores16+scores17+scores18+scores19+scores20+scores21+scores22+scores23+scores24+scores25+scores26+scores27+scores28+scores29+scores30+scores31+scores32+scores33+scores34);
}

void loda_cardio_c5(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score
    ){
    #pragma HLS INTERFACE axis register both port=data
    #pragma HLS INTERFACE axis register both port=score
    #pragma HLS INTERFACE s_axilite register port=return

    DataBus_OUT score_out;
    bool flag;

    // Input Conversion
    
    interface_t X0[DIM_MAX],X1[DIM_MAX],X2[DIM_MAX],X3[DIM_MAX],X4[DIM_MAX],X5[DIM_MAX],X6[DIM_MAX],X7[DIM_MAX],X8[DIM_MAX],X9[DIM_MAX],X10[DIM_MAX],X11[DIM_MAX],X12[DIM_MAX],X13[DIM_MAX],X14[DIM_MAX],X15[DIM_MAX],X16[DIM_MAX],X17[DIM_MAX],X18[DIM_MAX],X19[DIM_MAX],X20[DIM_MAX],X21[DIM_MAX],X22[DIM_MAX],X23[DIM_MAX],X24[DIM_MAX],X25[DIM_MAX],X26[DIM_MAX],X27[DIM_MAX],X28[DIM_MAX],X29[DIM_MAX],X30[DIM_MAX],X31[DIM_MAX],X32[DIM_MAX],X33[DIM_MAX],X34[DIM_MAX];

    DataBus_IN data_X = data.read();
    interface_t data_X_fixed = (interface_t)data_X.data;
    
    windower(data_X_fixed, X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,X25,X26,X27,X28,X29,X30,X31,X32,X33,X34, flag);
    score_t score_out_fixed, score_out_fixed_r;
    if(flag == 1){
        loda_ensemble(
                X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,X25,X26,X27,X28,X29,X30,X31,X32,X33,X34,
                score_out_fixed);
        score_out_fixed_r = (score_t)(((accum_t)score_out_fixed*(accum_t)0.02857142857142857- (accum_t)bottom_loda)*(accum_t)delta_loda);

        score_out.data = (float)score_out_fixed_r;
        score_out.last = data_X.last;
        score << score_out;
    }
}
    