#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR



cd $CURDIR/loda/cardio/ && rm -rf *
cd $CURDIR/loda/shuttle/ && rm -rf *
cd $CURDIR/loda/smtp1/ && rm -rf *
cd $CURDIR/loda/http1/ && rm -rf *

cd $CURDIR/rshash/cardio/ && rm -rf *
cd $CURDIR/rshash/shuttle/ && rm -rf *
cd $CURDIR/rshash/smtp1/ && rm -rf *
cd $CURDIR/rshash/http1/ && rm -rf *

cd $CURDIR/xstream/cardio/ && rm -rf *
cd $CURDIR/xstream/shuttle/ && rm -rf *
cd $CURDIR/xstream/smtp1/ && rm -rf *
cd $CURDIR/xstream/http1/ && rm -rf *

cd $CURDIR/_results/ && rm -rf *