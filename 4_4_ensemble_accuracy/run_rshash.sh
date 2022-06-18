#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/gcc/rshash && bash ./clear_rshash.sh

cd $CURDIR && python3 rshash.py --data_name cardio
cd $CURDIR && python3 rshash.py --data_name shuttle
cd $CURDIR && python3 rshash.py --data_name smtp1
cd $CURDIR && python3 rshash.py --data_name http1

cd $CURDIR && python3 rshash_gcc_gen.py --data_name cardio
cd $CURDIR && python3 rshash_gcc_gen.py --data_name shuttle
cd $CURDIR && python3 rshash_gcc_gen.py --data_name smtp1
cd $CURDIR && python3 rshash_gcc_gen.py --data_name http1

cd $CURDIR/gcc/rshash/ && bash ./run_cardio.sh
cd $CURDIR/gcc/rshash/ && bash ./run_shuttle.sh
cd $CURDIR/gcc/rshash/ && bash ./run_smtp1.sh
cd $CURDIR/gcc/rshash/ && bash ./run_http1.sh


