set data_name empty_ad
open_project -reset hls_default_${data_name}_prj
set_top empty_ad
add_files empty_ad.cpp
open_solution -reset "solution-rfsoc"
set_part {xczu28dr-ffvg1517-2-e}
    
create_clock -period 5 -name default
config_export -format ip_catalog -rtl verilog
csynth_design
export_design -format ip_catalog
exit