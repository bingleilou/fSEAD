#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


for e in 20 40 60 80 100 120 140
do
    for ((m=1; m<=10; m++))
    do
        cd $CURDIR/http1/E${e}/M${m} && make clean && make && bash run.sh
    done
done


