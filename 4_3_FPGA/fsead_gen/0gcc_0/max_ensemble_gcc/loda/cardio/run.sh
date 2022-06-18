#!/bin/bash

data="./../../../data_gcc/cardio_X"

start_time=$(date +%s%N)
echo "training: Doing"
time taskset -c 5 cat $data | ./loda_cardioE245 1831 > scores

echo "testing: Doing"

end_time=$(date +%s%N)
cost_time_us=$[ ($end_time-$start_time)/10**3 ] #us
cost_time_ms=$[ ($end_time-$start_time)/10**6 ] #ms
cost_time_s=$[ ($end_time-$start_time)/10**9 ] #s
echo "Bash Execution time is $(($cost_time_s)) s"
echo "Bash Execution time is $(($cost_time_ms)) ms"
echo "Bash Execution time is $(($cost_time_us)) us"
echo "E245(ms) "$(($cost_time_ms)) >> ./runtime