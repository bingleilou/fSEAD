#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/xstream/cardio/ && rm -rf *
cd $CURDIR/xstream/shuttle/ && rm -rf *
cd $CURDIR/xstream/smtp1/ && rm -rf *
cd $CURDIR/xstream/http1/ && rm -rf *
