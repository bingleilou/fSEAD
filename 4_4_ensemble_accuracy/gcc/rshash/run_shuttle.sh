#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


for e in 25 50 75 100 125 150 175
do
    for ((m=1; m<=10; m++))
    do
        cd $CURDIR/shuttle/E${e}/M${m} && make clean && make && bash run.sh
    done
done


