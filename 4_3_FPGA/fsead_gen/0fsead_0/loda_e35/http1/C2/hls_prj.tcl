set data_name http1
open_project -reset hls_loda_${data_name}_prj
set_top loda_http1_c2
add_files loda_http1_E35C2.cpp
add_files -tb loda_http1_E35C2_test.cpp

add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
# csim_design -clean
csynth_design
# cosim_design
export_design -format ip_catalog
exit