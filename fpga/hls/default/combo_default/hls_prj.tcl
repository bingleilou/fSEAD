set data_name empty_combo
open_project -reset hls_default_${data_name}_prj
set_top empty_combo
add_files empty_combo.cpp
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
csynth_design
export_design -format ip_catalog
exit