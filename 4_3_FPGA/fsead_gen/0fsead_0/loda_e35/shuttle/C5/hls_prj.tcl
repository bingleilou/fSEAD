set data_name shuttle
open_project -reset hls_loda_${data_name}_prj
set_top loda_shuttle_c5
add_files loda_shuttle_E35C5.cpp
add_files -tb loda_shuttle_E35C5_test.cpp

add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
# csim_design -clean
csynth_design
# cosim_design
export_design -format ip_catalog
exit