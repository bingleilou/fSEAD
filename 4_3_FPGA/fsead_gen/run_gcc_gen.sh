#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/0gcc_0/max_ensemble_gcc && bash ./clear_all.sh


cd $CURDIR && python3 loda_gcc_gen.py --data_name cardio
cd $CURDIR && python3 loda_gcc_gen.py --data_name shuttle
cd $CURDIR && python3 loda_gcc_gen.py --data_name smtp1
cd $CURDIR && python3 loda_gcc_gen.py --data_name http1
cd $CURDIR && python3 rshash_gcc_gen.py --data_name cardio
cd $CURDIR && python3 rshash_gcc_gen.py --data_name shuttle
cd $CURDIR && python3 rshash_gcc_gen.py --data_name smtp1
cd $CURDIR && python3 rshash_gcc_gen.py --data_name http1
cd $CURDIR && python3 xstream_gcc_gen.py --data_name cardio
cd $CURDIR && python3 xstream_gcc_gen.py --data_name shuttle
cd $CURDIR && python3 xstream_gcc_gen.py --data_name smtp1
cd $CURDIR && python3 xstream_gcc_gen.py --data_name http1

cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/cardio && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/shuttle && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/smtp1 && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/http1 && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/cardio && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/shuttle && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/smtp1 && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/http1 && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/cardio && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/shuttle && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/smtp1 && make clean && make && bash run.sh
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/http1 && make clean && make && bash run.sh

cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/cardio && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_cardio_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/shuttle && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_shuttle_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/smtp1 && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_smtp1_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/http1 && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_http1_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/cardio && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_cardio_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/shuttle && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_shuttle_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/smtp1 && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_smtp1_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/http1 && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_http1_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/cardio && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_cardio_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/shuttle && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_shuttle_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/smtp1 && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_smtp1_score
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/http1 && cp -rf scores $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_http1_score

cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/cardio && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_cardio_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/shuttle && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_shuttle_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/smtp1 && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_smtp1_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/loda/http1 && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/loda_http1_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/cardio && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_cardio_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/shuttle && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_shuttle_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/smtp1 && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_smtp1_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/rshash/http1 && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/rshash_http1_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/cardio && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_cardio_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/shuttle && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_shuttle_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/smtp1 && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_smtp1_runtime
cd $CURDIR/0gcc_0/max_ensemble_gcc/xstream/http1 && cp -rf runtime $CURDIR/0gcc_0/max_ensemble_gcc/_results/xstream_http1_runtime

cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad loda --data_name cardio
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad loda --data_name shuttle
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad loda --data_name smtp1
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad loda --data_name http1
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad rshash --data_name cardio
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad rshash --data_name shuttle
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad rshash --data_name smtp1
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad rshash --data_name http1
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad xstream --data_name cardio
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad xstream --data_name shuttle
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad xstream --data_name smtp1
cd $CURDIR/0gcc_0/max_ensemble_gcc && python3 auc_scores.py --ad xstream --data_name http1


