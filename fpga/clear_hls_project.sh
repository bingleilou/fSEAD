#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


cd $CURDIR/hls/combo/combo_s4_i4/ && make clean
cd $CURDIR/hls/combo/combo_s4_i3/ && make clean
cd $CURDIR/hls/combo/combo_s4_i2/ && make clean

cd $CURDIR/hls/combo/combo_m4_i4/ && make clean
cd $CURDIR/hls/combo/combo_m4_i3/ && make clean
cd $CURDIR/hls/combo/combo_m4_i2/ && make clean

cd $CURDIR/hls/combo/combo_w4_i4/ && make clean
cd $CURDIR/hls/combo/combo_w4_i3/ && make clean
cd $CURDIR/hls/combo/combo_w4_i2/ && make clean

cd $CURDIR/hls/combo/combo_o4_i4/ && make clean
cd $CURDIR/hls/combo/combo_o4_i3/ && make clean
cd $CURDIR/hls/combo/combo_o4_i2/ && make clean

cd $CURDIR/hls/default/combo_default/ && make clean
cd $CURDIR/hls/default/detector_default/ && make clean

for ((c=1; c<=7; c++))
do
    cd $CURDIR/hls/loda_e35/cardio/C${c}/ && make clean
    cd $CURDIR/hls/loda_e35/shuttle/C${c}/ && make clean
    cd $CURDIR/hls/loda_e35/smtp1/C${c}/ && make clean
    cd $CURDIR/hls/loda_e35/http1/C${c}/ && make clean
done

for ((c=1; c<=7; c++))
do
    cd $CURDIR/hls/rshash_e25/cardio/C${c}/ && make clean
    cd $CURDIR/hls/rshash_e25/shuttle/C${c}/ && make clean
    cd $CURDIR/hls/rshash_e25/smtp1/C${c}/ && make clean
    cd $CURDIR/hls/rshash_e25/http1/C${c}/ && make clean
done

for ((c=1; c<=7; c++))
do
    cd $CURDIR/hls/xstream_e20/cardio/C${c}/ && make clean
    cd $CURDIR/hls/xstream_e20/shuttle/C${c}/ && make clean
    cd $CURDIR/hls/xstream_e20/smtp1/C${c}/ && make clean
    cd $CURDIR/hls/xstream_e20/http1/C${c}/ && make clean
done
