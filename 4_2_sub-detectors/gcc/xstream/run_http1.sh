#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


for e in 2 3 4 5 6 7 8 9 10 20 40 60 80 100 120 140 160 180 200
do
    for ((m=1; m<=10; m++))
    do
        cd $CURDIR/http1/E${e}/M${m} && make clean && make && bash run.sh
    done
done


