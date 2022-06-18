create_pblock pblock_pr_combo_1
add_cells_to_pblock [get_pblocks pblock_pr_combo_1] [get_cells -quiet [list system_i/pr_combo_1]]
resize_pblock [get_pblocks pblock_pr_combo_1] -add {SLICE_X38Y307:SLICE_X58Y331}
resize_pblock [get_pblocks pblock_pr_combo_1] -add {DSP48E2_X7Y124:DSP48E2_X9Y131}
resize_pblock [get_pblocks pblock_pr_combo_1] -add {RAMB18_X4Y124:RAMB18_X5Y131}
resize_pblock [get_pblocks pblock_pr_combo_1] -add {RAMB36_X4Y62:RAMB36_X5Y65}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr_combo_1]
set_property IS_SOFT FALSE [get_pblocks pblock_pr_combo_1]
create_pblock pblock_pr_combo_2
add_cells_to_pblock [get_pblocks pblock_pr_combo_2] [get_cells -quiet [list system_i/pr_combo_2]]
resize_pblock [get_pblocks pblock_pr_combo_2] -add {SLICE_X38Y243:SLICE_X45Y289}
resize_pblock [get_pblocks pblock_pr_combo_2] -add {DSP48E2_X7Y98:DSP48E2_X8Y115}
resize_pblock [get_pblocks pblock_pr_combo_2] -add {RAMB18_X4Y98:RAMB18_X4Y115}
resize_pblock [get_pblocks pblock_pr_combo_2] -add {RAMB36_X4Y49:RAMB36_X4Y57}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr_combo_2]
set_property IS_SOFT FALSE [get_pblocks pblock_pr_combo_2]
create_pblock pblock_pr_combo_3
add_cells_to_pblock [get_pblocks pblock_pr_combo_3] [get_cells -quiet [list system_i/pr_combo_3]]
resize_pblock [get_pblocks pblock_pr_combo_3] -add {SLICE_X38Y181:SLICE_X46Y229}
resize_pblock [get_pblocks pblock_pr_combo_3] -add {DSP48E2_X7Y74:DSP48E2_X8Y91}
resize_pblock [get_pblocks pblock_pr_combo_3] -add {RAMB18_X4Y74:RAMB18_X4Y91}
resize_pblock [get_pblocks pblock_pr_combo_3] -add {RAMB36_X4Y37:RAMB36_X4Y45}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr_combo_3]
set_property IS_SOFT FALSE [get_pblocks pblock_pr_combo_3]


create_pblock pblock_pr1
add_cells_to_pblock [get_pblocks pblock_pr1] [get_cells -quiet [list system_i/pr1]]
resize_pblock [get_pblocks pblock_pr1] -add {SLICE_X0Y360:SLICE_X29Y479}
resize_pblock [get_pblocks pblock_pr1] -add {CMACE4_X0Y1:CMACE4_X0Y1}
resize_pblock [get_pblocks pblock_pr1] -add {DSP48E2_X0Y144:DSP48E2_X3Y191}
resize_pblock [get_pblocks pblock_pr1] -add {GTYE4_CHANNEL_X0Y12:GTYE4_CHANNEL_X0Y19}
resize_pblock [get_pblocks pblock_pr1] -add {GTYE4_COMMON_X0Y3:GTYE4_COMMON_X0Y4}
resize_pblock [get_pblocks pblock_pr1] -add {PCIE40E4_X0Y1:PCIE40E4_X0Y1}
resize_pblock [get_pblocks pblock_pr1] -add {RAMB18_X0Y144:RAMB18_X2Y191}
resize_pblock [get_pblocks pblock_pr1] -add {RAMB36_X0Y72:RAMB36_X2Y95}
resize_pblock [get_pblocks pblock_pr1] -add {URAM288_X0Y48:URAM288_X0Y79}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr1]
set_property IS_SOFT FALSE [get_pblocks pblock_pr1]

create_pblock pblock_pr2
add_cells_to_pblock [get_pblocks pblock_pr2] [get_cells -quiet [list system_i/pr2]]
resize_pblock [get_pblocks pblock_pr2] -add {SLICE_X38Y365:SLICE_X78Y479}
resize_pblock [get_pblocks pblock_pr2] -add {DSP48E2_X7Y146:DSP48E2_X13Y191}
resize_pblock [get_pblocks pblock_pr2] -add {FE_X0Y7:FE_X0Y7}
resize_pblock [get_pblocks pblock_pr2] -add {RAMB18_X4Y146:RAMB18_X7Y191}
resize_pblock [get_pblocks pblock_pr2] -add {RAMB36_X4Y73:RAMB36_X7Y95}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr2]
set_property IS_SOFT FALSE [get_pblocks pblock_pr2]

create_pblock pblock_pr3
add_cells_to_pblock [get_pblocks pblock_pr3] [get_cells -quiet [list system_i/pr3]]
resize_pblock [get_pblocks pblock_pr3] -add {SLICE_X89Y360:SLICE_X118Y478}
resize_pblock [get_pblocks pblock_pr3] -add {DSP48E2_X17Y144:DSP48E2_X22Y189}
resize_pblock [get_pblocks pblock_pr3] -add {HSDAC_X0Y2:HSDAC_X0Y2}
resize_pblock [get_pblocks pblock_pr3] -add {IOB_X1Y312:IOB_X1Y375}
resize_pblock [get_pblocks pblock_pr3] -add {RAMB18_X9Y144:RAMB18_X11Y189}
resize_pblock [get_pblocks pblock_pr3] -add {RAMB36_X9Y72:RAMB36_X11Y94}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr3]
set_property IS_SOFT FALSE [get_pblocks pblock_pr3]

create_pblock pblock_pr4
add_cells_to_pblock [get_pblocks pblock_pr4] [get_cells -quiet [list system_i/pr4]]
resize_pblock [get_pblocks pblock_pr4] -add {SLICE_X0Y180:SLICE_X29Y299}
resize_pblock [get_pblocks pblock_pr4] -add {CMACE4_X0Y0:CMACE4_X0Y0}
resize_pblock [get_pblocks pblock_pr4] -add {DSP48E2_X0Y72:DSP48E2_X3Y119}
resize_pblock [get_pblocks pblock_pr4] -add {GTYE4_CHANNEL_X0Y0:GTYE4_CHANNEL_X0Y7}
resize_pblock [get_pblocks pblock_pr4] -add {GTYE4_COMMON_X0Y0:GTYE4_COMMON_X0Y1}
resize_pblock [get_pblocks pblock_pr4] -add {PCIE40E4_X0Y0:PCIE40E4_X0Y0}
resize_pblock [get_pblocks pblock_pr4] -add {RAMB18_X0Y72:RAMB18_X2Y119}
resize_pblock [get_pblocks pblock_pr4] -add {RAMB36_X0Y36:RAMB36_X2Y59}
resize_pblock [get_pblocks pblock_pr4] -add {URAM288_X0Y0:URAM288_X0Y31}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr4]
set_property IS_SOFT FALSE [get_pblocks pblock_pr4]

create_pblock pblock_pr5
add_cells_to_pblock [get_pblocks pblock_pr5] [get_cells -quiet [list system_i/pr5]]
resize_pblock [get_pblocks pblock_pr5] -add {SLICE_X88Y181:SLICE_X118Y299}
resize_pblock [get_pblocks pblock_pr5] -add {DSP48E2_X17Y74:DSP48E2_X22Y119}
resize_pblock [get_pblocks pblock_pr5] -add {HSDAC_X0Y0:HSDAC_X0Y0}
resize_pblock [get_pblocks pblock_pr5] -add {IOB_X1Y182:IOB_X1Y245}
resize_pblock [get_pblocks pblock_pr5] -add {RAMB18_X9Y74:RAMB18_X11Y119}
resize_pblock [get_pblocks pblock_pr5] -add {RAMB36_X9Y37:RAMB36_X11Y59}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr5]
set_property IS_SOFT FALSE [get_pblocks pblock_pr5]

create_pblock pblock_pr6
add_cells_to_pblock [get_pblocks pblock_pr6] [get_cells -quiet [list system_i/pr6]]
resize_pblock [get_pblocks pblock_pr6] -add {SLICE_X38Y6:SLICE_X80Y119}
resize_pblock [get_pblocks pblock_pr6] -add {DSP48E2_X7Y4:DSP48E2_X14Y47}
resize_pblock [get_pblocks pblock_pr6] -add {FE_X0Y1:FE_X0Y1}
resize_pblock [get_pblocks pblock_pr6] -add {RAMB18_X4Y4:RAMB18_X7Y47}
resize_pblock [get_pblocks pblock_pr6] -add {RAMB36_X4Y2:RAMB36_X7Y23}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr6]
set_property IS_SOFT FALSE [get_pblocks pblock_pr6]

create_pblock pblock_pr7
add_cells_to_pblock [get_pblocks pblock_pr7] [get_cells -quiet [list system_i/pr7]]
resize_pblock [get_pblocks pblock_pr7] -add {SLICE_X88Y0:SLICE_X118Y132}
resize_pblock [get_pblocks pblock_pr7] -add {CONFIG_SITE_X0Y0:CONFIG_SITE_X0Y0}
resize_pblock [get_pblocks pblock_pr7] -add {DSP48E2_X17Y0:DSP48E2_X22Y51}
resize_pblock [get_pblocks pblock_pr7] -add {HSADC_X0Y0:HSADC_X0Y1}
resize_pblock [get_pblocks pblock_pr7] -add {IOB_X1Y0:IOB_X1Y37}
resize_pblock [get_pblocks pblock_pr7] -add {RAMB18_X9Y0:RAMB18_X11Y51}
resize_pblock [get_pblocks pblock_pr7] -add {RAMB36_X9Y0:RAMB36_X11Y25}
set_property SNAPPING_MODE ON [get_pblocks pblock_pr7]
set_property IS_SOFT FALSE [get_pblocks pblock_pr7]

create_pblock pblock_axis_switch
add_cells_to_pblock [get_pblocks pblock_axis_switch] [get_cells -quiet [list system_i/axis_switch]]
resize_pblock [get_pblocks pblock_axis_switch] -add {SLICE_X67Y166:SLICE_X77Y332}
resize_pblock [get_pblocks pblock_axis_switch] -add {DSP48E2_X11Y68:DSP48E2_X13Y131}
resize_pblock [get_pblocks pblock_axis_switch] -add {RAMB18_X7Y68:RAMB18_X7Y131}
resize_pblock [get_pblocks pblock_axis_switch] -add {RAMB36_X7Y34:RAMB36_X7Y65}

create_pblock pblock_axis_switch1
add_cells_to_pblock [get_pblocks pblock_axis_switch1] [get_cells -quiet [list system_i/axis_switch1]]
resize_pblock [get_pblocks pblock_axis_switch1] -add {SLICE_X52Y183:SLICE_X60Y289}
resize_pblock [get_pblocks pblock_axis_switch1] -add {DSP48E2_X9Y74:DSP48E2_X9Y115}




