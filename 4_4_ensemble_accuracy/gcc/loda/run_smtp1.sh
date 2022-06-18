#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


for e in 35 70 105 140 175 210 245
do
    for ((m=1; m<=10; m++))
    do
        cd $CURDIR/smtp1/E${e}/M${m} && make clean && make && bash run.sh
    done
done


