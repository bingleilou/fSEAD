import numpy as np
    
def print_params_hls_loda(data_path, data_name, ensemble, dim, batch_size, n_Bins, min_X, projections, delta, bottom_loda, delta_loda):
    f = open(data_path + data_name, "w")
    f.write("#define ENSEMBLE " + str(ensemble) + "\n")
    f.write("#define DIM_MAX " + str(dim) + "\n")
    f.write("#define BATCH_SIZE " + str(batch_size) + "\n")
    f.write("#define N_BINS " + str(n_Bins) + "\n")
    f.write("const static param_t bottom_loda = " + str(bottom_loda) + ";\n")
    f.write("const static param_t delta_loda = " + str(delta_loda) + ";\n")
    
    
    #######################################################
    ####                      min_X                     ###
    #######################################################
    f.write("static param_t " + 'loda_min_X' + "[" + str(ensemble) + "] = {")
    for j in range(ensemble-1):
        f.write(str(min_X[j]) + ",")
    f.write(str(min_X[ensemble-1]) + "};\n")
    
    #######################################################
    ####                   projections                  ###
    #######################################################
    ENSEMBLE = projections.shape[0]
    DIM = projections.shape[1]
    f.write("\n")
    f.write("static param_t " + 'loda_projections' + "[" + str(ENSEMBLE) + "][" + str(DIM) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(DIM-1):
            f.write(str(projections[i][j]) + ",")
        f.write(str(projections[i][DIM-1]) + "},\n{")
    for j in range(DIM-1):
        f.write(str(projections[ENSEMBLE-1][j]) + ",")
    f.write(str(projections[ENSEMBLE-1][DIM-1]) + "}};\n")
    
    #######################################################
    ####                    1/delta                     ###
    #######################################################
    ENSEMBLE = len(delta)
    f.write("\n")
    f.write("static param_t " + 'loda_delta' + "[" + str(ENSEMBLE) + "] = {")
    for j in range(ENSEMBLE-1):
        f.write(str(delta[j]) + ",")
    f.write(str(delta[ENSEMBLE-1]) + "};\n")

    #######################################################
    ####                    log_LUT                     ###
    #######################################################
    BATCH_SIZE = batch_size
    f.write("\n")
    f.write("const static score_t " + 'log_LUT_loda' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        if j==0:
            f.write(str(15.0) + ",")
        else:
            f.write(str(-np.log2(j/BATCH_SIZE)) + ",")
    f.write(str(-np.log2((BATCH_SIZE-1)/BATCH_SIZE)) + "};\n")
    
    f.flush()
    f.close()
    
def print_params_gcc_loda(data_path, data_name, ensemble, dim, batch_size, n_Bins, min_X, projections, delta, bottom_loda, delta_loda):
    f = open(data_path + data_name, "w")
    f.write("float bottom_loda = " + str(bottom_loda) + ";\n")
    f.write("float delta_loda = " + str(delta_loda) + ";\n")
    
    #######################################################
    ####                      min_X                     ###
    #######################################################
    f.write("float " + 'loda_min_X' + "[" + str(ensemble) + "] = {")
    for j in range(ensemble-1):
        f.write(str(min_X[j]) + ",")
    f.write(str(min_X[ensemble-1]) + "};\n")
    
    #######################################################
    ####                   projections                  ###
    #######################################################
    ENSEMBLE = projections.shape[0]
    DIM = projections.shape[1]
    f.write("\n")
    f.write("float " + 'loda_projections' + "[" + str(ENSEMBLE) + "][" + str(DIM) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(DIM-1):
            f.write(str(projections[i][j]) + ",")
        f.write(str(projections[i][DIM-1]) + "},\n{")
    for j in range(DIM-1):
        f.write(str(projections[ENSEMBLE-1][j]) + ",")
    f.write(str(projections[ENSEMBLE-1][DIM-1]) + "}};\n")
    
    #######################################################
    ####                    1/delta                     ###
    #######################################################
    ENSEMBLE = len(delta)
    f.write("\n")
    f.write("float " + 'loda_delta' + "[" + str(ENSEMBLE) + "] = {")
    for j in range(ENSEMBLE-1):
        f.write(str(delta[j]) + ",")
    f.write(str(delta[ENSEMBLE-1]) + "};\n")

    #######################################################
    ####                    log_LUT                     ###
    #######################################################
    BATCH_SIZE = batch_size
    f.write("\n")
    f.write("float " + 'log_LUT_loda' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        if j==0:
            f.write(str(15.0) + ",")
        else:
            f.write(str(-np.log2(j/BATCH_SIZE)) + ",")
    f.write(str(-np.log2((BATCH_SIZE-1)/BATCH_SIZE)) + "};\n")
    
    f.flush()
    f.close()
    
def print_params_hls_rshash(data_path, data_name, ensemble, dim, batch_size, num_hash, matrix_col, alpha_selected, f_selected, min_X, delta_X, bottom_rshash, delta_rshash):
    f = open(data_path + data_name, "w")
    f.write("#define ENSEMBLE " + str(ensemble) + "\n")
    f.write("#define DIM_MAX " + str(dim) + "\n")
    f.write("#define BATCH_SIZE " + str(batch_size) + "\n")
    f.write("#define HASH_NUM " + str(num_hash) + "\n")
    f.write("#define MATRIX_COL " + str(matrix_col) + "\n")
    f.write("const static param_t bottom_rshash = " + str(bottom_rshash) + ";\n")
    f.write("const static param_t delta_rshash = " + str(delta_rshash) + ";\n")

    #######################################################
    ####                  1/f_selected                  ###
    #######################################################
    f.write("static param_t " + 'rshash_f' + "[" + str(ensemble) + "] = {")
    for j in range(ensemble-1):
        f.write(str(f_selected[j]) + ",")
    f.write(str(f_selected[ensemble-1]) + "};\n")
    
    #######################################################
    ####                 alpha_selected                 ###
    #######################################################
    ENSEMBLE = alpha_selected.shape[0]
    DIM = alpha_selected.shape[1]
    f.write("\n")
    f.write("static param_t " + 'rshash_alpha' + "[" + str(ENSEMBLE) + "][" + str(DIM) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(DIM-1):
            f.write(str(alpha_selected[i][j]) + ",")
        f.write(str(alpha_selected[i][DIM-1]) + "},\n{")
    for j in range(DIM-1):
        f.write(str(alpha_selected[ENSEMBLE-1][j]) + ",")
    f.write(str(alpha_selected[ENSEMBLE-1][DIM-1]) + "}};\n")
    
    #######################################################
    ####                      min_X                     ###
    #######################################################
    f.write("static param_t " + 'rshash_min_X' + "[" + str(DIM) + "] = {")
    for j in range(DIM-1):
        f.write(str(min_X[j]) + ",")
    f.write(str(min_X[DIM-1]) + "};\n")
    
    #######################################################
    ####                   1/delta_X                    ###
    #######################################################
    f.write("static param_t " + 'rshash_delta_X' + "[" + str(DIM) + "] = {")
    for j in range(DIM-1):
        if delta_X[j] == np.inf:
            f.write(str(0.0) + ",")
        else:
            f.write(str(delta_X[j]) + ",")
    f.write(str(delta_X[DIM-1]) + "};\n")
    
    #######################################################
    ####                    log_LUT                     ###
    #######################################################
    BATCH_SIZE = batch_size
    f.write("\n")
    f.write("const static score_t " + 'log_LUT_rshash' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        f.write(str(-np.log2(1+j)) + ",")
    f.write(str(-np.log2(1 + BATCH_SIZE-1)) + "};\n")
    f.flush()
    f.close()
    
def print_params_gcc_rshash(data_path, data_name, ensemble, dim, batch_size, num_hash, matrix_col, alpha_selected, f_selected, min_X, delta_X, bottom_rshash, delta_rshash):
    f = open(data_path + data_name, "w")
    f.write("float bottom_rshash = " + str(bottom_rshash) + ";\n")
    f.write("float delta_rshash = " + str(delta_rshash) + ";\n")

    #######################################################
    ####                  1/f_selected                  ###
    #######################################################
    f.write("float " + 'rshash_f' + "[" + str(ensemble) + "] = {")
    for j in range(ensemble-1):
        f.write(str(f_selected[j]) + ",")
    f.write(str(f_selected[ensemble-1]) + "};\n")
    
    #######################################################
    ####                 alpha_selected                 ###
    #######################################################
    ENSEMBLE = alpha_selected.shape[0]
    DIM = alpha_selected.shape[1]
    f.write("\n")
    f.write("float " + 'rshash_alpha' + "[" + str(ENSEMBLE) + "][" + str(DIM) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(DIM-1):
            f.write(str(alpha_selected[i][j]) + ",")
        f.write(str(alpha_selected[i][DIM-1]) + "},\n{")
    for j in range(DIM-1):
        f.write(str(alpha_selected[ENSEMBLE-1][j]) + ",")
    f.write(str(alpha_selected[ENSEMBLE-1][DIM-1]) + "}};\n")
    
    #######################################################
    ####                      min_X                     ###
    #######################################################
    f.write("float " + 'rshash_min_X' + "[" + str(DIM) + "] = {")
    for j in range(DIM-1):
        f.write(str(min_X[j]) + ",")
    f.write(str(min_X[DIM-1]) + "};\n")
    
    #######################################################
    ####                   1/delta_X                    ###
    #######################################################
    f.write("float " + 'rshash_delta_X' + "[" + str(DIM) + "] = {")
    for j in range(DIM-1):
        if delta_X[j] == np.inf:
            f.write(str(0.0) + ",")
        else:
            f.write(str(delta_X[j]) + ",")
    f.write(str(delta_X[DIM-1]) + "};\n")
    
    #######################################################
    ####                    log_LUT                     ###
    #######################################################
    BATCH_SIZE = batch_size
    f.write("\n")
    f.write("float " + 'log_LUT_rshash' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        f.write(str(-np.log2(1+j)) + ",")
    f.write(str(-np.log2(1 + BATCH_SIZE-1)) + "};\n")
    f.flush()
    f.close()
    
    
def print_params_hls_xstream(data_path, data_name, ensemble, dim, batch_size, K, depth, matrix_col, R_T, fs, deltamax, shift_deltamax, shift, bottom_xstream, delta_xstream):
    f = open(data_path + data_name, "w")
    f.write("#define ENSEMBLE " + str(ensemble) + "\n")
    f.write("#define DIM_MAX " + str(dim) + "\n")
    f.write("#define BATCH_SIZE " + str(batch_size) + "\n")
    f.write("#define K_NUM " + str(K) + "\n")
    f.write("#define HASH_NUM " + str(depth) + "\n")
    f.write("#define MATRIX_COL " + str(matrix_col) + "\n")
    f.write("const static param_t bottom_xstream = " + str(bottom_xstream) + ";\n")
    f.write("const static param_t delta_xstream = " + str(delta_xstream) + ";\n")
    #######################################################
    ####                       fs                       ###
    #######################################################
    ENSEMBLE = fs.shape[0]
    DEPTH = fs.shape[1]
    f.write("\n")
    f.write("static param_t " + 'xstream_fs' + "[" + str(ENSEMBLE) + "][" + str(DEPTH) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(DEPTH-1):
            f.write(str(fs[i][j]) + ",")
        f.write(str(fs[i][DEPTH-1]) + "},\n{")
    for j in range(DEPTH-1):
        f.write(str(fs[ENSEMBLE-1][j]) + ",")
    f.write(str(fs[ENSEMBLE-1][DEPTH-1]) + "}};\n")
    
    #######################################################
    ####                       R_T                      ###
    #######################################################
    DIM = R_T.shape[0]
    K_NUM = R_T.shape[1]
    f.write("\n")
    f.write("static param_t " + 'xstream_R_T' + "[" + str(DIM) + "][" + str(K_NUM) + "] = {{")
    for i in range(DIM-1):
        for j in range(K_NUM-1):
            f.write(str(R_T[i][j]) + ",")
        f.write(str(R_T[i][K_NUM-1]) + "},\n{")
    for j in range(K_NUM-1):
        f.write(str(R_T[DIM-1][j]) + ",")
    f.write(str(R_T[DIM-1][K_NUM-1]) + "}};\n")
    
    #######################################################
    ####                  1/deltamax                    ###
    #######################################################
    K_NUM = len(deltamax)
    f.write("\n")
    f.write("static param_t " + 'xstream_deltamax' + "[" + str(K_NUM) + "] = {")
    for j in range(K_NUM-1):
        f.write(str(deltamax[j]) + ",")
    f.write(str(deltamax[K_NUM-1]) + "};\n")
    
    #######################################################
    ####            -shift_selected/deltamax            ###
    #######################################################
    DIM = shift_deltamax.shape[0]
    K_NUM = shift_deltamax.shape[1]
    f.write("\n")
    f.write("static param_t " + 'xstream_shift_deltamax' + "[" + str(DIM) + "][" + str(K_NUM) + "] = {{")
    for i in range(DIM-1):
        for j in range(K_NUM-1):
            f.write(str(shift_deltamax[i][j]) + ",")
        f.write(str(shift_deltamax[i][K_NUM-1]) + "},\n{")
    for j in range(K_NUM-1):
        f.write(str(shift_deltamax[DIM-1][j]) + ",")
    f.write(str(shift_deltamax[DIM-1][K_NUM-1]) + "}};\n")
    
    #######################################################
    ####                      shift                     ###
    #######################################################
    ENSEMBLE = shift.shape[0]
    K_NUM = shift.shape[1]
    f.write("\n")
    f.write("static param_t " + 'xstream_shift' + "[" + str(ENSEMBLE) + "][" + str(K_NUM) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(K_NUM-1):
            f.write(str(shift[i][j]) + ",")
        f.write(str(shift[i][K_NUM-1]) + "},\n{")
    for j in range(K_NUM-1):
        f.write(str(shift[ENSEMBLE-1][j]) + ",")
    f.write(str(shift[ENSEMBLE-1][K_NUM-1]) + "}};\n")
    
    #######################################################
    ####                    log_LUT                     ###
    #######################################################
    BATCH_SIZE = batch_size
    f.write("\n")
    f.write("const static score_t " + 'log_LUT_xstream_d0' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        f.write(str(np.log2(1+j)+0+1) + ",")
    f.write(str(np.log2(1 + BATCH_SIZE-1)+0+1) + "};\n")
    '''
    f.write("\n")
    f.write("const static score_t " + 'log_LUT_xstream_d1' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        f.write(str(np.log2(1+j)+1+1) + ",")
    f.write(str(np.log2(1 + BATCH_SIZE-1)+1+1) + "};\n")
    '''
    f.flush()
    f.close()

def print_params_gcc_xstream(data_path, data_name, ensemble, dim, batch_size, K, depth, matrix_col, R_T, fs, deltamax, shift_deltamax, shift, bottom_xstream, delta_xstream):
    f = open(data_path + data_name, "w")
    f.write("float bottom_xstream = " + str(bottom_xstream) + ";\n")
    f.write("float delta_xstream = " + str(delta_xstream) + ";\n")
    #######################################################
    ####                       fs                       ###
    #######################################################
    ENSEMBLE = fs.shape[0]
    DEPTH = fs.shape[1]
    f.write("\n")
    f.write("float " + 'xstream_fs' + "[" + str(ENSEMBLE) + "][" + str(DEPTH) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(DEPTH-1):
            f.write(str(fs[i][j]) + ",")
        f.write(str(fs[i][DEPTH-1]) + "},\n{")
    for j in range(DEPTH-1):
        f.write(str(fs[ENSEMBLE-1][j]) + ",")
    f.write(str(fs[ENSEMBLE-1][DEPTH-1]) + "}};\n")
    
    #######################################################
    ####                       R_T                      ###
    #######################################################
    DIM = R_T.shape[0]
    K_NUM = R_T.shape[1]
    f.write("\n")
    f.write("float " + 'xstream_R_T' + "[" + str(DIM) + "][" + str(K_NUM) + "] = {{")
    for i in range(DIM-1):
        for j in range(K_NUM-1):
            f.write(str(R_T[i][j]) + ",")
        f.write(str(R_T[i][K_NUM-1]) + "},\n{")
    for j in range(K_NUM-1):
        f.write(str(R_T[DIM-1][j]) + ",")
    f.write(str(R_T[DIM-1][K_NUM-1]) + "}};\n")
    
    #######################################################
    ####                  1/deltamax                    ###
    #######################################################
    K_NUM = len(deltamax)
    f.write("\n")
    f.write("float " + 'xstream_deltamax' + "[" + str(K_NUM) + "] = {")
    for j in range(K_NUM-1):
        f.write(str(deltamax[j]) + ",")
    f.write(str(deltamax[K_NUM-1]) + "};\n")
    
    #######################################################
    ####            -shift_selected/deltamax            ###
    #######################################################
    DIM = shift_deltamax.shape[0]
    K_NUM = shift_deltamax.shape[1]
    f.write("\n")
    f.write("float " + 'xstream_shift_deltamax' + "[" + str(DIM) + "][" + str(K_NUM) + "] = {{")
    for i in range(DIM-1):
        for j in range(K_NUM-1):
            f.write(str(shift_deltamax[i][j]) + ",")
        f.write(str(shift_deltamax[i][K_NUM-1]) + "},\n{")
    for j in range(K_NUM-1):
        f.write(str(shift_deltamax[DIM-1][j]) + ",")
    f.write(str(shift_deltamax[DIM-1][K_NUM-1]) + "}};\n")
    
    #######################################################
    ####                      shift                     ###
    #######################################################
    ENSEMBLE = shift.shape[0]
    K_NUM = shift.shape[1]
    f.write("\n")
    f.write("float " + 'xstream_shift' + "[" + str(ENSEMBLE) + "][" + str(K_NUM) + "] = {{")
    for i in range(ENSEMBLE-1):
        for j in range(K_NUM-1):
            f.write(str(shift[i][j]) + ",")
        f.write(str(shift[i][K_NUM-1]) + "},\n{")
    for j in range(K_NUM-1):
        f.write(str(shift[ENSEMBLE-1][j]) + ",")
    f.write(str(shift[ENSEMBLE-1][K_NUM-1]) + "}};\n")
    
    #######################################################
    ####                    log_LUT                     ###
    #######################################################
    BATCH_SIZE = batch_size
    f.write("\n")
    f.write("float " + 'log_LUT_xstream_d0' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        f.write(str(np.log2(1+j)+0+1) + ",")
    f.write(str(np.log2(1 + BATCH_SIZE-1)+0+1) + "};\n")
    
    f.write("\n")
    f.write("float " + 'log_LUT_xstream_d1' + "[" + str(BATCH_SIZE) + "] = {")
    for j in range(BATCH_SIZE-1):
        f.write(str(np.log2(1+j)+1+1) + ",")
    f.write(str(np.log2(1 + BATCH_SIZE-1)+1+1) + "};\n")
    f.flush()
    f.close()

