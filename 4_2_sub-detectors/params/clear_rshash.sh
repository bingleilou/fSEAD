#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/rshash/cardio/ && rm -rf *
cd $CURDIR/rshash/shuttle/ && rm -rf *
cd $CURDIR/rshash/smtp1/ && rm -rf *
cd $CURDIR/rshash/http1/ && rm -rf *
