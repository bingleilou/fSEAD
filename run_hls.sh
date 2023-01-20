#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


cd $CURDIR/fpga/ && bash ./clear_hls_code.sh
cd $CURDIR/fpga/ && bash ./clear_hls_project.sh

echo "=============== HLS code generation ================"
cd $CURDIR/fpga/ && python3 loda_hls_gen.py --data_name cardio
cd $CURDIR/fpga/ && python3 loda_hls_gen.py --data_name shuttle
cd $CURDIR/fpga/ && python3 loda_hls_gen.py --data_name smtp1
cd $CURDIR/fpga/ && python3 loda_hls_gen.py --data_name http1

cd $CURDIR/fpga/ && python3 rshash_hls_gen.py --data_name cardio
cd $CURDIR/fpga/ && python3 rshash_hls_gen.py --data_name shuttle
cd $CURDIR/fpga/ && python3 rshash_hls_gen.py --data_name smtp1
cd $CURDIR/fpga/ && python3 rshash_hls_gen.py --data_name http1

cd $CURDIR/fpga/ && python3 xstream_hls_gen.py --data_name cardio
cd $CURDIR/fpga/ && python3 xstream_hls_gen.py --data_name shuttle
cd $CURDIR/fpga/ && python3 xstream_hls_gen.py --data_name smtp1
cd $CURDIR/fpga/ && python3 xstream_hls_gen.py --data_name http1


echo "=============== Compile HLS code ================"
cd $CURDIR/fpga/hls/combo/combo_s4_i4/ && make all
cd $CURDIR/fpga/hls/combo/combo_s4_i3/ && make all
cd $CURDIR/fpga/hls/combo/combo_s4_i2/ && make all

cd $CURDIR/fpga/hls/combo/combo_m4_i4/ && make all
cd $CURDIR/fpga/hls/combo/combo_m4_i3/ && make all
cd $CURDIR/fpga/hls/combo/combo_m4_i2/ && make all

cd $CURDIR/fpga/hls/combo/combo_w4_i4/ && make all
cd $CURDIR/fpga/hls/combo/combo_w4_i3/ && make all
cd $CURDIR/fpga/hls/combo/combo_w4_i2/ && make all

cd $CURDIR/fpga/hls/combo/combo_o4_i4/ && make all
cd $CURDIR/fpga/hls/combo/combo_o4_i3/ && make all
cd $CURDIR/fpga/hls/combo/combo_o4_i2/ && make all

cd $CURDIR/fpga/hls/default/combo_default/ && make all
cd $CURDIR/fpga/hls/default/detector_default/ && make all

for ((c=1; c<=7; c++))
do
    cd $CURDIR/fpga/hls/loda_e35/cardio/C${c}/ && make all
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C${c}/ && make all
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C${c}/ && make all
    cd $CURDIR/fpga/hls/loda_e35/http1/C${c}/ && make all
done

for ((c=1; c<=7; c++))
do
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C${c}/ && make all
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C${c}/ && make all
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C${c}/ && make all
    cd $CURDIR/fpga/hls/rshash_e25/http1/C${c}/ && make all
done

for ((c=1; c<=7; c++))
do
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C${c}/ && make all
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C${c}/ && make all
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C${c}/ && make all
    cd $CURDIR/fpga/hls/xstream_e20/http1/C${c}/ && make all
done
