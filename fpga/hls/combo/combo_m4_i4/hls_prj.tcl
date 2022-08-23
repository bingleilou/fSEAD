set data_name m4_i4
open_project -reset hls_combo_${data_name}_prj
set_top combo_max_i4
add_files combo.cpp
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
csynth_design
export_design -format ip_catalog
exit