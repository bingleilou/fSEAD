set data_name http1
open_project -reset hls_xstream_${data_name}_prj
set_top xstream_http1_c5
add_files xstream_http1_E20C5.cpp
add_files -tb xstream_http1_E20C5_test.cpp

add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
# csim_design -clean
csynth_design
# cosim_design
export_design -format ip_catalog
exit