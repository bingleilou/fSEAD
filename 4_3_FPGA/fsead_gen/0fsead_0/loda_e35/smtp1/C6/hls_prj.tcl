set data_name smtp1
open_project -reset hls_loda_${data_name}_prj
set_top loda_smtp1_c6
add_files loda_smtp1_E35C6.cpp
add_files -tb loda_smtp1_E35C6_test.cpp

add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
# csim_design -clean
csynth_design
# cosim_design
export_design -format ip_catalog
exit