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
gnome-terminal  --title="combo"  -- bash -c " cd $CURDIR/fpga/hls/combo/combo_s4_i4/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_s4_i3/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_s4_i2/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_m4_i4/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_m4_i3/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_m4_i2/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_w4_i4/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_w4_i3/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_w4_i2/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_o4_i4/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_o4_i3/ && make all; \
    cd $CURDIR/fpga/hls/combo/combo_o4_i2/ && make all; \
    cd $CURDIR/fpga/hls/default/combo_default/ && make all; \
    cd $CURDIR/fpga/hls/default/detector_default/ && make all; \
"

gnome-terminal  --title="C1"  -- bash -c " cd $CURDIR/fpga/hls/loda_e35/cardio/C1/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C1/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C1/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/http1/C1/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C1/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C1/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C1/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/http1/C1/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C1/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C1/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C1/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/http1/C1/ && make all; \
"

gnome-terminal  --title="C2"  -- bash -c " cd $CURDIR/fpga/hls/loda_e35/cardio/C2/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C2/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C2/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/http1/C2/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C2/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C2/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C2/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/http1/C2/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C2/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C2/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C2/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/http1/C2/ && make all; \
"

gnome-terminal  --title="C3"  -- bash -c " cd $CURDIR/fpga/hls/loda_e35/cardio/C3/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C3/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C3/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/http1/C3/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C3/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C3/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C3/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/http1/C3/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C3/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C3/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C3/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/http1/C3/ && make all; \
"

gnome-terminal  --title="C4"  -- bash -c " cd $CURDIR/fpga/hls/loda_e35/cardio/C4/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C4/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C4/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/http1/C4/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C4/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C4/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C4/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/http1/C4/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C4/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C4/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C4/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/http1/C4/ && make all; \
"

gnome-terminal  --title="C5"  -- bash -c " cd $CURDIR/fpga/hls/loda_e35/cardio/C5/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C5/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C5/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/http1/C5/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C5/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C5/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C5/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/http1/C5/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C5/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C5/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C5/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/http1/C5/ && make all; \
"

gnome-terminal  --title="C6"  -- bash -c " cd $CURDIR/fpga/hls/loda_e35/cardio/C6/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C6/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C6/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/http1/C6/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C6/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C6/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C6/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/http1/C6/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C6/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C6/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C6/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/http1/C6/ && make all; \
"

gnome-terminal  --title="C7"  -- bash -c " cd $CURDIR/fpga/hls/loda_e35/cardio/C7/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/shuttle/C7/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/smtp1/C7/ && make all; \
    cd $CURDIR/fpga/hls/loda_e35/http1/C7/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/cardio/C7/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/shuttle/C7/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/smtp1/C7/ && make all; \
    cd $CURDIR/fpga/hls/rshash_e25/http1/C7/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/cardio/C7/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/shuttle/C7/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/smtp1/C7/ && make all; \
    cd $CURDIR/fpga/hls/xstream_e20/http1/C7/ && make all; \
"




