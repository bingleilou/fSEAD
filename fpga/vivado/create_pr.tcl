set overlay_name "system"
set design_name "system"

array set pr_array {
  0 pr1
  1 pr2
  2 pr3
  3 pr4
  4 pr5
  5 pr6
  6 pr7
  7 pr_combo_1
  8 pr_combo_2
  9 pr_combo_3
}

array set pd_array {
  0 pd_pr1
  1 pd_pr2
  2 pd_pr3
  3 pd_pr4
  4 pd_pr5
  5 pd_pr6
  6 pd_pr7
  7 pd_pr_combo_1
  8 pd_pr_combo_2
  9 pd_pr_combo_3
}

# as many of these as we have sub designs
array set rm_array_c1 {
  0 loda_cardio_c1
  1 rshash_cardio_c1
  2 xstream_cardio_c1
  3 loda_shuttle_c1
  4 rshash_shuttle_c1
  5 xstream_shuttle_c1
  6 loda_smtp1_c1
  7 rshash_smtp1_c1
  8 xstream_smtp1_c1
  9 loda_http1_c1
  10 rshash_http1_c1
  11 xstream_http1_c1
  12 empty_ad
}

array set rm_array_c2 {
  0 loda_cardio_c2
  1 rshash_cardio_c2
  2 xstream_cardio_c2
  3 loda_shuttle_c2
  4 rshash_shuttle_c2
  5 xstream_shuttle_c2
  6 loda_smtp1_c2
  7 rshash_smtp1_c2
  8 xstream_smtp1_c2
  9 loda_http1_c2
  10 rshash_http1_c2
  11 xstream_http1_c2
  12 empty_ad
}

array set rm_array_c3 {
  0 loda_cardio_c3
  1 rshash_cardio_c3
  2 xstream_cardio_c3
  3 loda_shuttle_c3
  4 rshash_shuttle_c3
  5 xstream_shuttle_c3
  6 loda_smtp1_c3
  7 rshash_smtp1_c3
  8 xstream_smtp1_c3
  9 loda_http1_c3
  10 rshash_http1_c3
  11 xstream_http1_c3
  12 empty_ad
}

array set rm_array_c4 {
  0 loda_cardio_c4
  1 rshash_cardio_c4
  2 xstream_cardio_c4
  3 loda_shuttle_c4
  4 rshash_shuttle_c4
  5 xstream_shuttle_c4
  6 loda_smtp1_c4
  7 rshash_smtp1_c4
  8 xstream_smtp1_c4
  9 loda_http1_c4
  10 rshash_http1_c4
  11 xstream_http1_c4
  12 empty_ad
}

array set rm_array_c5 {
  0 loda_cardio_c5
  1 rshash_cardio_c5
  2 xstream_cardio_c5
  3 loda_shuttle_c5
  4 rshash_shuttle_c5
  5 xstream_shuttle_c5
  6 loda_smtp1_c5
  7 rshash_smtp1_c5
  8 xstream_smtp1_c5
  9 loda_http1_c5
  10 rshash_http1_c5
  11 xstream_http1_c5
  12 empty_ad
}

array set rm_array_c6 {
  0 loda_cardio_c6
  1 rshash_cardio_c6
  2 xstream_cardio_c6
  3 loda_shuttle_c6
  4 rshash_shuttle_c6
  5 xstream_shuttle_c6
  6 loda_smtp1_c6
  7 rshash_smtp1_c6
  8 xstream_smtp1_c6
  9 loda_http1_c6
  10 rshash_http1_c6
  11 xstream_http1_c6
  12 empty_ad
}

array set rm_array_c7 {
  0 loda_cardio_c7
  1 rshash_cardio_c7
  2 xstream_cardio_c7
  3 loda_shuttle_c7
  4 rshash_shuttle_c7
  5 xstream_shuttle_c7
  6 loda_smtp1_c7
  7 rshash_smtp1_c7
  8 xstream_smtp1_c7
  9 loda_http1_c7
  10 rshash_http1_c7
  11 xstream_http1_c7
  12 empty_ad
}

array set rm_array_combo_1 {
  0 combo_score_i4
  1 combo_score_i3
  2 combo_score_i2
  3 empty_combo
}

array set rm_array_combo_2 {
  0 combo_score_i4
  1 combo_score_i3
  2 combo_score_i2
  3 empty_combo
}

array set rm_array_combo_3 {
  0 combo_score_i4
  1 combo_score_i3
  2 combo_score_i2
  3 empty_combo
}

# function to add reconfigurable module
proc add_rm {pd_name rm_name} {
  create_bd_design "rm_${rm_name}_${pd_name}"
  source ./partial/${rm_name}.tcl
  validate_bd_design
  save_bd_design
  set_property synth_checkpoint_mode None [get_files rm_${rm_name}_${pd_name}.bd]
  create_reconfig_module -name rm_${rm_name}_${pd_name} -partition_def [get_partition_defs ${pd_name}] -define_from rm_${rm_name}_${pd_name}
}

proc add_region {pr_name pd_name rm_names} {
  upvar $rm_names rm

  # add constraints file into project
  #import_files -fileset constrs_1 -norecurse ./vivado/constraints/${pr_name}.xdc
  #update_compile_order -fileset sources_1

  # add partition definition and default reconfigurable module
  set_property PR_FLOW true [current_project]
  set curdesign [current_bd_design]
  puts $curdesign
  create_bd_design -cell [get_bd_cells /${pr_name}] ${rm(0)}_${pd_name}
  set_property synth_checkpoint_mode None [get_files ${rm(0)}_${pd_name}.bd]
  set pd_instance [create_partition_def -name ${pd_name} -module ${rm(0)}_${pd_name}]
  create_reconfig_module -name ${rm(0)}_${pd_name} -partition_def $pd_instance -define_from ${rm(0)}_${pd_name}

  # replace the pr region
  current_bd_design $curdesign
  set new_pd_cell [create_bd_cell -type module -reference $pd_instance pr_region_temp]
  replace_bd_cell  [get_bd_cells /${pr_name}] $new_pd_cell
  delete_bd_objs  [get_bd_cells /${pr_name}]
  set_property name ${pr_name} $new_pd_cell

  # validate and save current top design
  validate_bd_design
  save_bd_design

  # add each rm
  foreach n [array names rm] {
    add_rm ${pd_name} $rm($n)
  }
  current_bd_design $curdesign
}
#START OF FLOW
# open project and block design
open_project -quiet ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd
set_param project.enablePRFlowIPI 1
set_param bitstream.enablePR 2341
set_param hd.enablePR 1234

# add constraints file into project
import_files -fileset constrs_1 -norecurse ./vivado/constraints/${overlay_name}.xdc
update_compile_order -fileset sources_1


# add pr regions and the designs for each region
foreach i [array names pr_array] {
  if { $i == 0 } {
    add_region $pr_array($i) $pd_array($i) rm_array_c1
  } elseif { $i ==1 } {
    add_region $pr_array($i) $pd_array($i) rm_array_c2
  } elseif { $i ==2 } {
    add_region $pr_array($i) $pd_array($i) rm_array_c3
  } elseif { $i ==3 } {
    add_region $pr_array($i) $pd_array($i) rm_array_c4
  } elseif { $i ==4 } {
    add_region $pr_array($i) $pd_array($i) rm_array_c5
  } elseif { $i ==5 } {
    add_region $pr_array($i) $pd_array($i) rm_array_c6
  } elseif { $i ==6 } {
    add_region $pr_array($i) $pd_array($i) rm_array_c7
  } elseif { $i ==7 } {
    add_region $pr_array($i) $pd_array($i) rm_array_combo_1
  } elseif { $i ==8 } {
    add_region $pr_array($i) $pd_array($i) rm_array_combo_2
  } elseif { $i ==9 } {
    add_region $pr_array($i) $pd_array($i) rm_array_combo_3
  } else { }
}
########################################################################################################

