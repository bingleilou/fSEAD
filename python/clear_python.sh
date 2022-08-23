#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/params/loda/cardio/ && rm -rf *
cd $CURDIR/params/loda/shuttle/ && rm -rf *
cd $CURDIR/params/loda/smtp1/ && rm -rf *
cd $CURDIR/params/loda/http1/ && rm -rf *

cd $CURDIR/params/rshash/cardio/ && rm -rf *
cd $CURDIR/params/rshash/shuttle/ && rm -rf *
cd $CURDIR/params/rshash/smtp1/ && rm -rf *
cd $CURDIR/params/rshash/http1/ && rm -rf *

cd $CURDIR/params/xstream/cardio/ && rm -rf *
cd $CURDIR/params/xstream/shuttle/ && rm -rf *
cd $CURDIR/params/xstream/smtp1/ && rm -rf *
cd $CURDIR/params/xstream/http1/ && rm -rf *

cd $CURDIR/scores/loda/ && rm -rf *
cd $CURDIR/scores/rshash/ && rm -rf *
cd $CURDIR/scores/xstream/ && rm -rf *