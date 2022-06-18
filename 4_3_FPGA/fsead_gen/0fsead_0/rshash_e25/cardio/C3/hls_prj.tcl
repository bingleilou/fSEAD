set data_name cardio
open_project -reset hls_rshash_${data_name}_prj
set_top rshash_cardio_c3
add_files rshash_cardio_E25C3.cpp
add_files -tb rshash_cardio_E25C3_test.cpp

add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
# csim_design -clean
csynth_design
# cosim_design
export_design -format ip_catalog
exit