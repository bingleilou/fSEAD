#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/gcc/xstream && bash ./clear_xstream.sh

cd $CURDIR && python3 xstream.py --data_name cardio
cd $CURDIR && python3 xstream.py --data_name shuttle
cd $CURDIR && python3 xstream.py --data_name smtp1
cd $CURDIR && python3 xstream.py --data_name http1

cd $CURDIR && python3 xstream_gcc_gen.py --data_name cardio
cd $CURDIR && python3 xstream_gcc_gen.py --data_name shuttle
cd $CURDIR && python3 xstream_gcc_gen.py --data_name smtp1
cd $CURDIR && python3 xstream_gcc_gen.py --data_name http1

cd $CURDIR/gcc/xstream/ && bash ./run_cardio.sh
cd $CURDIR/gcc/xstream/ && bash ./run_shuttle.sh
cd $CURDIR/gcc/xstream/ && bash ./run_smtp1.sh
cd $CURDIR/gcc/xstream/ && bash ./run_http1.sh

cd $CURDIR && python3 compare_scores.py --ad xstream

