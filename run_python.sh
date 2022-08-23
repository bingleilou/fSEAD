#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/python/ && bash ./clear_python.sh

cd $CURDIR/python && python3 loda.py --data_name cardio --save_en 1
cd $CURDIR/python && python3 loda.py --data_name shuttle --save_en 1
cd $CURDIR/python && python3 loda.py --data_name smtp1 --save_en 1
cd $CURDIR/python && python3 loda.py --data_name http1 --save_en 1
cd $CURDIR/python && python3 rshash.py --data_name cardio --save_en 1
cd $CURDIR/python && python3 rshash.py --data_name shuttle --save_en 1
cd $CURDIR/python && python3 rshash.py --data_name smtp1 --save_en 1
cd $CURDIR/python && python3 rshash.py --data_name http1 --save_en 1
cd $CURDIR/python && python3 xstream.py --data_name cardio --save_en 1
cd $CURDIR/python && python3 xstream.py --data_name shuttle --save_en 1
cd $CURDIR/python && python3 xstream.py --data_name smtp1 --save_en 1
cd $CURDIR/python && python3 xstream.py --data_name http1 --save_en 1

