#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR


for e in 20 40 60 80 100 120 140
do
    cd $CURDIR/cardio/E${e}  && rm -rf runtime
    cd $CURDIR/shuttle/E${e}  && rm -rf runtime
    cd $CURDIR/smtp1/E${e}  && rm -rf runtime
    cd $CURDIR/http1/E${e}  && rm -rf runtime
    for ((m=1; m<=10; m++))
    do
        cd $CURDIR/cardio/E${e}/M${m} && rm -rf *
        cd $CURDIR/shuttle/E${e}/M${m} && rm -rf *
        cd $CURDIR/smtp1/E${e}/M${m} && rm -rf *
        cd $CURDIR/http1/E${e}/M${m} && rm -rf *
    done
done
