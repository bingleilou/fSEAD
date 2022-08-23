set data_name shuttle
open_project -reset hls_xstream_${data_name}_prj
set_top xstream_shuttle_c7
add_files xstream_shuttle_E20C7.cpp
add_files -tb xstream_shuttle_E20C7_test.cpp

add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
# csim_design -clean
csynth_design
# cosim_design
export_design -format ip_catalog
exit