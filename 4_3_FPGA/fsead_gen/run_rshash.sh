#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


#cd $CURDIR && python3 rshash.py --data_name cardio --save_en 1
#cd $CURDIR && python3 rshash.py --data_name shuttle --save_en 1
#cd $CURDIR && python3 rshash.py --data_name smtp1 --save_en 1
#cd $CURDIR && python3 rshash.py --data_name http1 --save_en 1
#cd $CURDIR && python3 rshash.py --data_name kddcup38

cd $CURDIR && python3 rshash_hls_gen.py --data_name cardio
cd $CURDIR && python3 rshash_hls_gen.py --data_name shuttle
cd $CURDIR && python3 rshash_hls_gen.py --data_name smtp1
cd $CURDIR && python3 rshash_hls_gen.py --data_name http1
#cd $CURDIR && python3 rshash_hls_gen.py --data_name kddcup38

