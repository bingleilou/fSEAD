#!/bin/bash

CURDIR=$(cd $(dirname ${BASH_SOURCE[0]}); pwd )
echo $CURDIR

cd $CURDIR/python/ && bash ./clear_python.sh


gnome-terminal  --title="loda-cardio"  -- bash -c "cd $CURDIR/python && python3 loda.py --data_name cardio --save_en 1"
gnome-terminal  --title="loda-shuttle" -- bash -c "cd $CURDIR/python && python3 loda.py --data_name shuttle --save_en 1"
gnome-terminal  --title="loda-smtp1"   -- bash -c "cd $CURDIR/python && python3 loda.py --data_name smtp1 --save_en 1"
gnome-terminal  --title="loda-http1"   -- bash -c "cd $CURDIR/python && python3 loda.py --data_name http1 --save_en 1"

gnome-terminal  --title="rshash-cardio"  -- bash -c "cd $CURDIR/python && python3 rshash.py --data_name cardio --save_en 1"
gnome-terminal  --title="rshash-shuttle" -- bash -c "cd $CURDIR/python && python3 rshash.py --data_name shuttle --save_en 1"
gnome-terminal  --title="rshash-smtp1"   -- bash -c "cd $CURDIR/python && python3 rshash.py --data_name smtp1 --save_en 1"
gnome-terminal  --title="rshash-http1"   -- bash -c "cd $CURDIR/python && python3 rshash.py --data_name http1 --save_en 1"

gnome-terminal  --title="xstream-cardio"  -- bash -c "cd $CURDIR/python && python3 xstream.py --data_name cardio --save_en 1"
gnome-terminal  --title="xstream-shuttle" -- bash -c "cd $CURDIR/python && python3 xstream.py --data_name shuttle --save_en 1"
gnome-terminal  --title="xstream-smtp1"   -- bash -c "cd $CURDIR/python && python3 xstream.py --data_name smtp1 --save_en 1"
gnome-terminal  --title="xstream-http1"   -- bash -c "cd $CURDIR/python && python3 xstream.py --data_name http1 --save_en 1"
