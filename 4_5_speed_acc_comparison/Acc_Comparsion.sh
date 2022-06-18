#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


echo "=============== GCC ================"
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad loda --data_name cardio
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad loda --data_name shuttle
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad loda --data_name smtp1
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad loda --data_name http1

cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad rshash --data_name cardio
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad rshash --data_name shuttle
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad rshash --data_name smtp1
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad rshash --data_name http1

cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad xstream --data_name cardio
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad xstream --data_name shuttle
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad xstream --data_name smtp1
cd $CURDIR/../4_3_FPGA/fsead_gen/0gcc_0/max_ensemble_gcc/ && python3 auc_scores.py --ad xstream --data_name http1

echo "=============== FPGA ================"
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad loda --data_name cardio
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad loda --data_name shuttle
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad loda --data_name smtp1
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad loda --data_name http1

cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad rshash --data_name cardio
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad rshash --data_name shuttle
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad rshash --data_name smtp1
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad rshash --data_name http1

cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad xstream --data_name cardio
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad xstream --data_name shuttle
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad xstream --data_name smtp1
cd $CURDIR/pynq_scores_labels/ && python3 auc_scores.py --ad xstream --data_name http1