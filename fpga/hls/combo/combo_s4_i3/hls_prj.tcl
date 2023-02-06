set data_name s4_i3
open_project -reset hls_combo_${data_name}_prj
set_top combo_score_i3
add_files combo.cpp
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 2.5 -name default
config_export -format ip_catalog -rtl verilog
csynth_design
export_design -format ip_catalog
exit