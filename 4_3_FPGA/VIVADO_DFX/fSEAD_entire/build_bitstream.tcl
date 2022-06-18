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


# open project and block design
open_project -quiet ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd
set_param project.enablePRFlowIPI 1
set_param bitstream.enablePR 2341
set_param hd.enablePR 1234

# synthesis
launch_runs synth_1 -jobs 16
wait_on_run synth_1

set proj_pr_flow [get_property PR_FLOW [current_project]]
if {$proj_pr_flow == 1} {
   setup_pr_configuration -v
}

# implementation
launch_runs impl_1 -to_step write_bitstream -jobs 16
wait_on_run impl_1
file copy -force ./${overlay_name}/${overlay_name}.runs/impl_1/${design_name}_wrapper.bit ./BIT_HWH/${design_name}.bit

set child_impl_runs [get_runs child_*]
foreach  { impl_run } $child_impl_runs  {
    launch_runs $impl_run -to_step write_bitstream -jobs 16
    wait_on_run $impl_run
    set bits [glob -type f ./${overlay_name}/${overlay_name}.runs/${impl_run}/*_partial.bit]
    foreach { bit } $bits {
        file copy -force $bit ./BIT_HWH/
    }
}

# copy project hwh file
file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/hw_handoff/${design_name}.hwh ./BIT_HWH/${overlay_name}.hwh

# rename partial bit files and copy over hwh files
foreach i [array names pr_array] {
  if { $i == 0 } {
    foreach r [array names rm_array_c1] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_c1($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_c1($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_c1($r)_$pd_array($i)/hw_handoff/rm_$rm_array_c1($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_c1($r).hwh
    }
  } elseif { $i ==1 } {
    foreach r [array names rm_array_c2] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_c2($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_c2($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_c2($r)_$pd_array($i)/hw_handoff/rm_$rm_array_c2($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_c2($r).hwh
    }
  } elseif { $i ==2 } {
    foreach r [array names rm_array_c3] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_c3($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_c3($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_c3($r)_$pd_array($i)/hw_handoff/rm_$rm_array_c3($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_c3($r).hwh
    }
  } elseif { $i ==3 } {
    foreach r [array names rm_array_c4] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_c4($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_c4($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_c4($r)_$pd_array($i)/hw_handoff/rm_$rm_array_c4($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_c4($r).hwh
    }
  } elseif { $i ==4 } {
    foreach r [array names rm_array_c5] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_c5($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_c5($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_c5($r)_$pd_array($i)/hw_handoff/rm_$rm_array_c5($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_c5($r).hwh
    }
  } elseif { $i ==5 } {
    foreach r [array names rm_array_c6] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_c6($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_c6($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_c6($r)_$pd_array($i)/hw_handoff/rm_$rm_array_c6($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_c6($r).hwh
    }
  } elseif { $i ==6 } {
    foreach r [array names rm_array_c7] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_c7($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_c7($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_c7($r)_$pd_array($i)/hw_handoff/rm_$rm_array_c7($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_c7($r).hwh
    }
  } elseif { $i ==7 } {
    foreach r [array names rm_array_combo_1] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_combo_1($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_combo_1($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_combo_1($r)_$pd_array($i)/hw_handoff/rm_$rm_array_combo_1($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_combo_1($r).hwh
    }
  } elseif { $i ==8 } {
    foreach r [array names rm_array_combo_2] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_combo_2($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_combo_2($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_combo_2($r)_$pd_array($i)/hw_handoff/rm_$rm_array_combo_2($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_combo_2($r).hwh
    }
  } elseif { $i ==9 } {
    foreach r [array names rm_array_combo_3] {
      file rename -force ./BIT_HWH/${design_name}_i_$pr_array($i)_rm_$rm_array_combo_3($r)_$pd_array($i)_partial.bit ./BIT_HWH/$pr_array($i)_$rm_array_combo_3($r).bit
      file copy -force ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/rm_$rm_array_combo_3($r)_$pd_array($i)/hw_handoff/rm_$rm_array_combo_3($r)_$pd_array($i).hwh ./BIT_HWH/$pr_array($i)_$rm_array_combo_3($r).hwh
    }
  } else { }
}