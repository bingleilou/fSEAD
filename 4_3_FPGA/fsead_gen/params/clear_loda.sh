#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/loda/cardio/ && rm -rf *
cd $CURDIR/loda/shuttle/ && rm -rf *
cd $CURDIR/loda/smtp1/ && rm -rf *
cd $CURDIR/loda/http1/ && rm -rf *
