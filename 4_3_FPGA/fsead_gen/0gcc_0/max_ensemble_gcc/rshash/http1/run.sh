#!/bin/bash

data="./../../../data_gcc/http1_X"

start_time=$(date +%s%N)
echo "training: Doing"
time taskset -c 5 cat $data | ./rshash_http1E175 567498 > scores

echo "testing: Doing"

end_time=$(date +%s%N)
cost_time_us=$[ ($end_time-$start_time)/10**3 ] #us
cost_time_ms=$[ ($end_time-$start_time)/10**6 ] #ms
cost_time_s=$[ ($end_time-$start_time)/10**9 ] #s
echo "Bash Execution time is $(($cost_time_s)) s"
echo "Bash Execution time is $(($cost_time_ms)) ms"
echo "Bash Execution time is $(($cost_time_us)) us"
echo "E175(ms) "$(($cost_time_ms)) >> ./runtime