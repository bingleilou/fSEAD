set data_name cardio
open_project -reset hls_xstream_${data_name}_prj
set_top xstream_cardio_c1
add_files xstream_cardio_E20C1.cpp
add_files -tb xstream_cardio_E20C1_test.cpp

add_files -tb data
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
# csim_design -clean
csynth_design
# cosim_design
export_design -format ip_catalog
exit