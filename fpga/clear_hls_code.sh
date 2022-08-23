#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


for ((c=1; c<=7; c++))
do
    cd $CURDIR/hls/loda_e35/cardio/C${c}/ && rm -rf *
    cd $CURDIR/hls/loda_e35/shuttle/C${c}/ && rm -rf *
    cd $CURDIR/hls/loda_e35/smtp1/C${c}/ && rm -rf *
    cd $CURDIR/hls/loda_e35/http1/C${c}/ && rm -rf *
done

for ((c=1; c<=7; c++))
do
    cd $CURDIR/hls/rshash_e25/cardio/C${c}/ && rm -rf *
    cd $CURDIR/hls/rshash_e25/shuttle/C${c}/ && rm -rf *
    cd $CURDIR/hls/rshash_e25/smtp1/C${c}/ && rm -rf *
    cd $CURDIR/hls/rshash_e25/http1/C${c}/ && rm -rf *
done

for ((c=1; c<=7; c++))
do
    cd $CURDIR/hls/xstream_e20/cardio/C${c}/ && rm -rf *
    cd $CURDIR/hls/xstream_e20/shuttle/C${c}/ && rm -rf *
    cd $CURDIR/hls/xstream_e20/smtp1/C${c}/ && rm -rf *
    cd $CURDIR/hls/xstream_e20/http1/C${c}/ && rm -rf *
done