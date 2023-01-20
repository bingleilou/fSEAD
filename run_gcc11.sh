#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/gcc/ && bash ./clear_gcc.sh

cd $CURDIR/gcc && python3 loda_gcc11_gen.py --data_name cardio
cd $CURDIR/gcc && python3 loda_gcc11_gen.py --data_name shuttle
cd $CURDIR/gcc && python3 loda_gcc11_gen.py --data_name smtp1
cd $CURDIR/gcc && python3 loda_gcc11_gen.py --data_name http1
cd $CURDIR/gcc && python3 rshash_gcc11_gen.py --data_name cardio
cd $CURDIR/gcc && python3 rshash_gcc11_gen.py --data_name shuttle
cd $CURDIR/gcc && python3 rshash_gcc11_gen.py --data_name smtp1
cd $CURDIR/gcc && python3 rshash_gcc11_gen.py --data_name http1
cd $CURDIR/gcc && python3 xstream_gcc11_gen.py --data_name cardio
cd $CURDIR/gcc && python3 xstream_gcc11_gen.py --data_name shuttle
cd $CURDIR/gcc && python3 xstream_gcc11_gen.py --data_name smtp1
cd $CURDIR/gcc && python3 xstream_gcc11_gen.py --data_name http1

cd $CURDIR/gcc/loda/cardio/ && make && bash ./run.sh
cd $CURDIR/gcc/loda/shuttle/ && make && bash ./run.sh
cd $CURDIR/gcc/loda/smtp1/ && make && bash ./run.sh
cd $CURDIR/gcc/loda/http1/ && make && bash ./run.sh
cd $CURDIR/gcc/rshash/cardio/ && make && bash ./run.sh
cd $CURDIR/gcc/rshash/shuttle/ && make && bash ./run.sh
cd $CURDIR/gcc/rshash/smtp1/ && make && bash ./run.sh
cd $CURDIR/gcc/rshash/http1/ && make && bash ./run.sh
cd $CURDIR/gcc/xstream/cardio/ && make && bash ./run.sh
cd $CURDIR/gcc/xstream/shuttle/ && make && bash ./run.sh
cd $CURDIR/gcc/xstream/smtp1/ && make && bash ./run.sh
cd $CURDIR/gcc/xstream/http1/ && make && bash ./run.sh


echo "=============== GCC Scores ================"
cd $CURDIR/gcc/ && python3 auc_scores.py --ad loda --data_name cardio
cd $CURDIR/gcc/ && python3 auc_scores.py --ad loda --data_name shuttle
cd $CURDIR/gcc/ && python3 auc_scores.py --ad loda --data_name smtp1
cd $CURDIR/gcc/ && python3 auc_scores.py --ad loda --data_name http1

cd $CURDIR/gcc/ && python3 auc_scores.py --ad rshash --data_name cardio
cd $CURDIR/gcc/ && python3 auc_scores.py --ad rshash --data_name shuttle
cd $CURDIR/gcc/ && python3 auc_scores.py --ad rshash --data_name smtp1
cd $CURDIR/gcc/ && python3 auc_scores.py --ad rshash --data_name http1

cd $CURDIR/gcc/ && python3 auc_scores.py --ad xstream --data_name cardio
cd $CURDIR/gcc/ && python3 auc_scores.py --ad xstream --data_name shuttle
cd $CURDIR/gcc/ && python3 auc_scores.py --ad xstream --data_name smtp1
cd $CURDIR/gcc/ && python3 auc_scores.py --ad xstream --data_name http1

