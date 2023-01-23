
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set overlay_name "system"
set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project ${overlay_name} ${overlay_name} -part xczu28dr-ffvg1517-2-e
   set_property BOARD_PART xilinx.com:zcu111:part0:1.2 [current_project]
}

set_property  ip_repo_paths  {
 ./../hls/loda_e35/cardio/C1/hls_loda_cardio_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/cardio/C2/hls_loda_cardio_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/cardio/C3/hls_loda_cardio_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/cardio/C4/hls_loda_cardio_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/cardio/C5/hls_loda_cardio_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/cardio/C6/hls_loda_cardio_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/cardio/C7/hls_loda_cardio_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/shuttle/C1/hls_loda_shuttle_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/shuttle/C2/hls_loda_shuttle_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/shuttle/C3/hls_loda_shuttle_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/shuttle/C4/hls_loda_shuttle_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/shuttle/C5/hls_loda_shuttle_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/shuttle/C6/hls_loda_shuttle_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/shuttle/C7/hls_loda_shuttle_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/smtp1/C1/hls_loda_smtp1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/smtp1/C2/hls_loda_smtp1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/smtp1/C3/hls_loda_smtp1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/smtp1/C4/hls_loda_smtp1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/smtp1/C5/hls_loda_smtp1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/smtp1/C6/hls_loda_smtp1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/smtp1/C7/hls_loda_smtp1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/http1/C1/hls_loda_http1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/http1/C2/hls_loda_http1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/http1/C3/hls_loda_http1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/http1/C4/hls_loda_http1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/http1/C5/hls_loda_http1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/http1/C6/hls_loda_http1_prj/solution-rfsoc/impl \
 ./../hls/loda_e35/http1/C7/hls_loda_http1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/cardio/C1/hls_rshash_cardio_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/cardio/C2/hls_rshash_cardio_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/cardio/C3/hls_rshash_cardio_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/cardio/C4/hls_rshash_cardio_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/cardio/C5/hls_rshash_cardio_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/cardio/C6/hls_rshash_cardio_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/cardio/C7/hls_rshash_cardio_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/shuttle/C1/hls_rshash_shuttle_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/shuttle/C2/hls_rshash_shuttle_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/shuttle/C3/hls_rshash_shuttle_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/shuttle/C4/hls_rshash_shuttle_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/shuttle/C5/hls_rshash_shuttle_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/shuttle/C6/hls_rshash_shuttle_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/shuttle/C7/hls_rshash_shuttle_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/smtp1/C1/hls_rshash_smtp1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/smtp1/C2/hls_rshash_smtp1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/smtp1/C3/hls_rshash_smtp1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/smtp1/C4/hls_rshash_smtp1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/smtp1/C5/hls_rshash_smtp1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/smtp1/C6/hls_rshash_smtp1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/smtp1/C7/hls_rshash_smtp1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/http1/C1/hls_rshash_http1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/http1/C2/hls_rshash_http1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/http1/C3/hls_rshash_http1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/http1/C4/hls_rshash_http1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/http1/C5/hls_rshash_http1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/http1/C6/hls_rshash_http1_prj/solution-rfsoc/impl \
 ./../hls/rshash_e25/http1/C7/hls_rshash_http1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/cardio/C1/hls_xstream_cardio_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/cardio/C2/hls_xstream_cardio_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/cardio/C3/hls_xstream_cardio_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/cardio/C4/hls_xstream_cardio_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/cardio/C5/hls_xstream_cardio_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/cardio/C6/hls_xstream_cardio_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/cardio/C7/hls_xstream_cardio_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/shuttle/C1/hls_xstream_shuttle_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/shuttle/C2/hls_xstream_shuttle_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/shuttle/C3/hls_xstream_shuttle_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/shuttle/C4/hls_xstream_shuttle_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/shuttle/C5/hls_xstream_shuttle_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/shuttle/C6/hls_xstream_shuttle_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/shuttle/C7/hls_xstream_shuttle_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/smtp1/C1/hls_xstream_smtp1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/smtp1/C2/hls_xstream_smtp1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/smtp1/C3/hls_xstream_smtp1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/smtp1/C4/hls_xstream_smtp1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/smtp1/C5/hls_xstream_smtp1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/smtp1/C6/hls_xstream_smtp1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/smtp1/C7/hls_xstream_smtp1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/http1/C1/hls_xstream_http1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/http1/C2/hls_xstream_http1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/http1/C3/hls_xstream_http1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/http1/C4/hls_xstream_http1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/http1/C5/hls_xstream_http1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/http1/C6/hls_xstream_http1_prj/solution-rfsoc/impl \
 ./../hls/xstream_e20/http1/C7/hls_xstream_http1_prj/solution-rfsoc/impl \
 ./../hls/combo/combo_s4_i2/hls_combo_s4_i2_prj/solution-rfsoc/impl \
 ./../hls/combo/combo_s4_i3/hls_combo_s4_i3_prj/solution-rfsoc/impl \
 ./../hls/combo/combo_s4_i4/hls_combo_s4_i4_prj/solution-rfsoc/impl \
 ./../hls/default/combo_default/hls_default_empty_combo_prj/solution-rfsoc/impl \
 ./../hls/default/detector_default/hls_default_empty_ad_prj/solution-rfsoc/impl \
 } [current_project]
update_ip_catalog


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_dma:7.1\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:dfx_decoupler:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:zynq_ultra_ps_e:3.3\
xilinx.com:hls:loda_cardio_c1:1.0\
xilinx.com:hls:loda_cardio_c2:1.0\
xilinx.com:hls:loda_cardio_c3:1.0\
xilinx.com:hls:loda_cardio_c4:1.0\
xilinx.com:hls:loda_cardio_c5:1.0\
xilinx.com:hls:loda_cardio_c6:1.0\
xilinx.com:hls:loda_cardio_c7:1.0\
xilinx.com:hls:combo_score_i4:1.0\
xilinx.com:hls:combo_score_i3:1.0\
xilinx.com:hls:combo_score_i2:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: pr_combo_3
proc create_hier_cell_pr_combo_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr_combo_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 OUT_r

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: combo_score_i2, and set properties
  set combo_score_i2 [ create_bd_cell -type ip -vlnv xilinx.com:hls:combo_score_i2:1.0 combo_score_i2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins combo_score_i2/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net combo_score_i4_IN1 [get_bd_intf_pins IN1] [get_bd_intf_pins combo_score_i2/IN1]
  connect_bd_intf_net -intf_net combo_score_i4_IN2 [get_bd_intf_pins IN2] [get_bd_intf_pins combo_score_i2/IN2]
  connect_bd_intf_net -intf_net combo_score_i4_IN3 [get_bd_intf_pins IN3] [get_bd_intf_pins combo_score_i2/IN3]
  connect_bd_intf_net -intf_net combo_score_i4_IN4 [get_bd_intf_pins IN4] [get_bd_intf_pins combo_score_i2/IN4]
  connect_bd_intf_net -intf_net combo_score_i4_OUT_r [get_bd_intf_pins OUT_r] [get_bd_intf_pins combo_score_i2/OUT_r]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins combo_score_i2/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins combo_score_i2/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr_combo_2
proc create_hier_cell_pr_combo_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr_combo_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 OUT_r

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: combo_score_i3, and set properties
  set combo_score_i3 [ create_bd_cell -type ip -vlnv xilinx.com:hls:combo_score_i3:1.0 combo_score_i3 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins combo_score_i3/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net combo_score_i4_IN1 [get_bd_intf_pins IN1] [get_bd_intf_pins combo_score_i3/IN1]
  connect_bd_intf_net -intf_net combo_score_i4_IN2 [get_bd_intf_pins IN2] [get_bd_intf_pins combo_score_i3/IN2]
  connect_bd_intf_net -intf_net combo_score_i4_IN3 [get_bd_intf_pins IN3] [get_bd_intf_pins combo_score_i3/IN3]
  connect_bd_intf_net -intf_net combo_score_i4_IN4 [get_bd_intf_pins IN4] [get_bd_intf_pins combo_score_i3/IN4]
  connect_bd_intf_net -intf_net combo_score_i4_OUT_r [get_bd_intf_pins OUT_r] [get_bd_intf_pins combo_score_i3/OUT_r]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins combo_score_i3/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins combo_score_i3/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr_combo_1
proc create_hier_cell_pr_combo_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr_combo_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 IN4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 OUT_r

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: combo_score_i4, and set properties
  set combo_score_i4 [ create_bd_cell -type ip -vlnv xilinx.com:hls:combo_score_i4:1.0 combo_score_i4 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins combo_score_i4/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net combo_score_i4_IN1 [get_bd_intf_pins IN1] [get_bd_intf_pins combo_score_i4/IN1]
  connect_bd_intf_net -intf_net combo_score_i4_IN2 [get_bd_intf_pins IN2] [get_bd_intf_pins combo_score_i4/IN2]
  connect_bd_intf_net -intf_net combo_score_i4_IN3 [get_bd_intf_pins IN3] [get_bd_intf_pins combo_score_i4/IN3]
  connect_bd_intf_net -intf_net combo_score_i4_IN4 [get_bd_intf_pins IN4] [get_bd_intf_pins combo_score_i4/IN4]
  connect_bd_intf_net -intf_net combo_score_i4_OUT_r [get_bd_intf_pins OUT_r] [get_bd_intf_pins combo_score_i4/OUT_r]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins combo_score_i4/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins combo_score_i4/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr7
proc create_hier_cell_pr7 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr7() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 score


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: loda_cardio_c7, and set properties
  set loda_cardio_c7 [ create_bd_cell -type ip -vlnv xilinx.com:hls:loda_cardio_c7:1.0 loda_cardio_c7 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins loda_cardio_c7/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net xstream_cardio_data [get_bd_intf_pins data] [get_bd_intf_pins loda_cardio_c7/data]
  connect_bd_intf_net -intf_net xstream_cardio_score [get_bd_intf_pins score] [get_bd_intf_pins loda_cardio_c7/score]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins loda_cardio_c7/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins loda_cardio_c7/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr6
proc create_hier_cell_pr6 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr6() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 score


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: loda_cardio_c6, and set properties
  set loda_cardio_c6 [ create_bd_cell -type ip -vlnv xilinx.com:hls:loda_cardio_c6:1.0 loda_cardio_c6 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins loda_cardio_c6/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net xstream_cardio_data [get_bd_intf_pins data] [get_bd_intf_pins loda_cardio_c6/data]
  connect_bd_intf_net -intf_net xstream_cardio_score [get_bd_intf_pins score] [get_bd_intf_pins loda_cardio_c6/score]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins loda_cardio_c6/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins loda_cardio_c6/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr5
proc create_hier_cell_pr5 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr5() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 score


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: loda_cardio_c5, and set properties
  set loda_cardio_c5 [ create_bd_cell -type ip -vlnv xilinx.com:hls:loda_cardio_c5:1.0 loda_cardio_c5 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins loda_cardio_c5/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net xstream_cardio_data [get_bd_intf_pins data] [get_bd_intf_pins loda_cardio_c5/data]
  connect_bd_intf_net -intf_net xstream_cardio_score [get_bd_intf_pins score] [get_bd_intf_pins loda_cardio_c5/score]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins loda_cardio_c5/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins loda_cardio_c5/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr4
proc create_hier_cell_pr4 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr4() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 score


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: loda_cardio_c4, and set properties
  set loda_cardio_c4 [ create_bd_cell -type ip -vlnv xilinx.com:hls:loda_cardio_c4:1.0 loda_cardio_c4 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins loda_cardio_c4/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net xstream_cardio_data [get_bd_intf_pins data] [get_bd_intf_pins loda_cardio_c4/data]
  connect_bd_intf_net -intf_net xstream_cardio_score [get_bd_intf_pins score] [get_bd_intf_pins loda_cardio_c4/score]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins loda_cardio_c4/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins loda_cardio_c4/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr3
proc create_hier_cell_pr3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 score


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: loda_cardio_c3, and set properties
  set loda_cardio_c3 [ create_bd_cell -type ip -vlnv xilinx.com:hls:loda_cardio_c3:1.0 loda_cardio_c3 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins loda_cardio_c3/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net xstream_cardio_data [get_bd_intf_pins data] [get_bd_intf_pins loda_cardio_c3/data]
  connect_bd_intf_net -intf_net xstream_cardio_score [get_bd_intf_pins score] [get_bd_intf_pins loda_cardio_c3/score]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins loda_cardio_c3/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins loda_cardio_c3/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr2
proc create_hier_cell_pr2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 score


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: loda_cardio_c2, and set properties
  set loda_cardio_c2 [ create_bd_cell -type ip -vlnv xilinx.com:hls:loda_cardio_c2:1.0 loda_cardio_c2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins loda_cardio_c2/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net xstream_cardio_data [get_bd_intf_pins data] [get_bd_intf_pins loda_cardio_c2/data]
  connect_bd_intf_net -intf_net xstream_cardio_score [get_bd_intf_pins score] [get_bd_intf_pins loda_cardio_c2/score]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins loda_cardio_c2/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins loda_cardio_c2/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pr1
proc create_hier_cell_pr1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pr1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 data

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_AXILiteS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 score


  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: loda_cardio_c1, and set properties
  set loda_cardio_c1 [ create_bd_cell -type ip -vlnv xilinx.com:hls:loda_cardio_c1:1.0 loda_cardio_c1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_AXILiteS] [get_bd_intf_pins loda_cardio_c1/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net xstream_cardio_data [get_bd_intf_pins data] [get_bd_intf_pins loda_cardio_c1/data]
  connect_bd_intf_net -intf_net xstream_cardio_score [get_bd_intf_pins score] [get_bd_intf_pins loda_cardio_c1/score]

  # Create port connections
  connect_bd_net -net ap_clk_1 [get_bd_pins s_axi_aclk] [get_bd_pins loda_cardio_c1/ap_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins loda_cardio_c1/ap_rst_n]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set dip_switches_8bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 dip_switches_8bits ]


  # Create ports

  # Create instance: axi_dma_in0, and set properties
  set axi_dma_in0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_in0 ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_in0

  # Create instance: axi_dma_in1, and set properties
  set axi_dma_in1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_in1 ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_in1

  # Create instance: axi_dma_in2, and set properties
  set axi_dma_in2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_in2 ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_in2

  # Create instance: axi_dma_in3, and set properties
  set axi_dma_in3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_in3 ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_in3

  # Create instance: axi_dma_in4, and set properties
  set axi_dma_in4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_in4 ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_in4

  # Create instance: axi_dma_in5, and set properties
  set axi_dma_in5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_in5 ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_in5

  # Create instance: axi_dma_in6, and set properties
  set axi_dma_in6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_in6 ]
  set_property -dict [ list \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_in6

  # Create instance: axi_smc, and set properties
  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property -dict [ list \
   CONFIG.NUM_SI {14} \
 ] $axi_smc

  # Create instance: axis_switch, and set properties
  set axis_switch [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {14} \
   CONFIG.NUM_SI {10} \
   CONFIG.OUTPUT_REG {1} \
   CONFIG.ROUTING_MODE {1} \
 ] $axis_switch

  # Create instance: axis_switch1, and set properties
  set axis_switch1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch1 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {15} \
   CONFIG.NUM_SI {10} \
   CONFIG.OUTPUT_REG {1} \
   CONFIG.ROUTING_MODE {1} \
 ] $axis_switch1

  # Create instance: dfx_decoupler_1, and set properties
  set dfx_decoupler_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_1 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} data {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 1 WIDTH 4}}} score {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 53} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_1

  # Create instance: dfx_decoupler_2, and set properties
  set dfx_decoupler_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_2 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} data {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 1 WIDTH 4}}} score {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 53} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_2

  # Create instance: dfx_decoupler_3, and set properties
  set dfx_decoupler_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_3 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} data {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 1 WIDTH 4}}} score {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 53} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_3

  # Create instance: dfx_decoupler_4, and set properties
  set dfx_decoupler_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_4 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} data {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 1 WIDTH 4}}} score {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 51} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_4

  # Create instance: dfx_decoupler_5, and set properties
  set dfx_decoupler_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_5 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} data {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 1 WIDTH 4}}} score {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 51} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_5

  # Create instance: dfx_decoupler_6, and set properties
  set dfx_decoupler_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_6 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} data {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 1 WIDTH 4}}} score {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 51} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_6

  # Create instance: dfx_decoupler_7, and set properties
  set dfx_decoupler_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_7 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} data {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 1 WIDTH 4}}} score {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 51} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_7

  # Create instance: dfx_decoupler_combo1, and set properties
  set dfx_decoupler_combo1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_combo1 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} IN1 {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN2 {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN3 {ID 3 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} OUT_r {ID 4 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN4 {ID 5 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 53} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_3 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_5 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_6 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_combo1

  # Create instance: dfx_decoupler_combo2, and set properties
  set dfx_decoupler_combo2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_combo2 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} IN1 {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN2 {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN3 {ID 3 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} OUT_r {ID 4 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN4 {ID 5 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 53} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_3 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_5 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_6 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_combo2

  # Create instance: dfx_decoupler_combo3, and set properties
  set dfx_decoupler_combo3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:dfx_decoupler:1.0 dfx_decoupler_combo3 ]
  set_property -dict [ list \
   CONFIG.ALL_PARAMS {HAS_SIGNAL_CONTROL 0 HAS_SIGNAL_STATUS 0 HAS_AXI_LITE 1 INTF {axilite {ID 0 VLNV xilinx.com:interface:aximm_rtl:1.0 PROTOCOL axi4lite SIGNALS {ARVALID {PRESENT 1 WIDTH 1} ARREADY {PRESENT 1 WIDTH 1} AWVALID {PRESENT 1 WIDTH 1} AWREADY {PRESENT 1 WIDTH 1} BVALID {PRESENT 1 WIDTH 1} BREADY {PRESENT 1 WIDTH 1} RVALID {PRESENT 1 WIDTH 1} RREADY {PRESENT 1 WIDTH 1} WVALID {PRESENT 1 WIDTH 1} WREADY {PRESENT 1 WIDTH 1} AWADDR {PRESENT 1 WIDTH 40} AWLEN {PRESENT 0 WIDTH 8} AWSIZE {PRESENT 0 WIDTH 3} AWBURST {PRESENT 0 WIDTH 2} AWLOCK {PRESENT 0 WIDTH 1} AWCACHE {PRESENT 0 WIDTH 4} AWPROT {PRESENT 1 WIDTH 3} WDATA {PRESENT 1 WIDTH 32} WSTRB {PRESENT 1 WIDTH 4} WLAST {PRESENT 0 WIDTH 1} BRESP {PRESENT 1 WIDTH 2} ARADDR {PRESENT 1 WIDTH 40} ARLEN {PRESENT 0 WIDTH 8} ARSIZE {PRESENT 0 WIDTH 3} ARBURST {PRESENT 0 WIDTH 2} ARLOCK {PRESENT 0 WIDTH 1} ARCACHE {PRESENT 0 WIDTH 4} ARPROT {PRESENT 1 WIDTH 3} RDATA {PRESENT 1 WIDTH 32} RRESP {PRESENT 1 WIDTH 2} RLAST {PRESENT 0 WIDTH 1} AWID {PRESENT 0 WIDTH 0} AWREGION {PRESENT 1 WIDTH 4} AWQOS {PRESENT 1 WIDTH 4} AWUSER {PRESENT 0 WIDTH 0} WID {PRESENT 0 WIDTH 0} WUSER {PRESENT 0 WIDTH 0} BID {PRESENT 0 WIDTH 0} BUSER {PRESENT 0 WIDTH 0} ARID {PRESENT 0 WIDTH 0} ARREGION {PRESENT 1 WIDTH 4} ARQOS {PRESENT 1 WIDTH 4} ARUSER {PRESENT 0 WIDTH 0} RID {PRESENT 0 WIDTH 0} RUSER {PRESENT 0 WIDTH 0}}} IN1 {ID 1 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN2 {ID 2 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN3 {ID 3 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} OUT_r {ID 4 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 0 WIDTH 0} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}} IN4 {ID 5 VLNV xilinx.com:interface:axis_rtl:1.0 SIGNALS {TVALID {PRESENT 1 WIDTH 1} TREADY {PRESENT 1 WIDTH 1} TDATA {PRESENT 1 WIDTH 32} TUSER {PRESENT 0 WIDTH 0} TLAST {PRESENT 1 WIDTH 1} TID {PRESENT 0 WIDTH 0} TDEST {PRESENT 1 WIDTH 4} TSTRB {PRESENT 0 WIDTH 4} TKEEP {PRESENT 0 WIDTH 4}}}} IPI_PROP_COUNT 53} \
   CONFIG.GUI_HAS_AXI_LITE {1} \
   CONFIG.GUI_HAS_SIGNAL_CONTROL {0} \
   CONFIG.GUI_HAS_SIGNAL_STATUS {0} \
   CONFIG.GUI_INTERFACE_NAME {axilite} \
   CONFIG.GUI_INTERFACE_PROTOCOL {axi4lite} \
   CONFIG.GUI_SELECT_INTERFACE {0} \
   CONFIG.GUI_SELECT_VLNV {xilinx.com:interface:aximm_rtl:1.0} \
   CONFIG.GUI_SIGNAL_DECOUPLED_0 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_1 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_2 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_3 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_4 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_5 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_6 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_7 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_8 {true} \
   CONFIG.GUI_SIGNAL_DECOUPLED_9 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_0 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_1 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_2 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_3 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_4 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_5 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_6 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_7 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_8 {true} \
   CONFIG.GUI_SIGNAL_PRESENT_9 {true} \
   CONFIG.GUI_SIGNAL_SELECT_0 {ARVALID} \
   CONFIG.GUI_SIGNAL_SELECT_1 {ARREADY} \
   CONFIG.GUI_SIGNAL_SELECT_2 {AWVALID} \
   CONFIG.GUI_SIGNAL_SELECT_3 {AWREADY} \
   CONFIG.GUI_SIGNAL_SELECT_4 {BVALID} \
   CONFIG.GUI_SIGNAL_SELECT_5 {BREADY} \
   CONFIG.GUI_SIGNAL_SELECT_6 {RVALID} \
   CONFIG.GUI_SIGNAL_SELECT_7 {RREADY} \
   CONFIG.GUI_SIGNAL_SELECT_8 {WVALID} \
   CONFIG.GUI_SIGNAL_SELECT_9 {WREADY} \
   CONFIG.GUI_SIGNAL_WIDTH_2 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_3 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_5 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_6 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_7 {1} \
   CONFIG.GUI_SIGNAL_WIDTH_8 {1} \
 ] $dfx_decoupler_combo3

  # Create instance: pr1
  create_hier_cell_pr1 [current_bd_instance .] pr1

  # Create instance: pr2
  create_hier_cell_pr2 [current_bd_instance .] pr2

  # Create instance: pr3
  create_hier_cell_pr3 [current_bd_instance .] pr3

  # Create instance: pr4
  create_hier_cell_pr4 [current_bd_instance .] pr4

  # Create instance: pr5
  create_hier_cell_pr5 [current_bd_instance .] pr5

  # Create instance: pr6
  create_hier_cell_pr6 [current_bd_instance .] pr6

  # Create instance: pr7
  create_hier_cell_pr7 [current_bd_instance .] pr7

  # Create instance: pr_combo_1
  create_hier_cell_pr_combo_1 [current_bd_instance .] pr_combo_1

  # Create instance: pr_combo_2
  create_hier_cell_pr_combo_2 [current_bd_instance .] pr_combo_2

  # Create instance: pr_combo_3
  create_hier_cell_pr_combo_3 [current_bd_instance .] pr_combo_3

  # Create instance: ps8_0_axi_periph, and set properties
  set ps8_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps8_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.M06_HAS_REGSLICE {4} \
   CONFIG.M07_HAS_REGSLICE {4} \
   CONFIG.M08_HAS_REGSLICE {4} \
   CONFIG.M09_HAS_REGSLICE {4} \
   CONFIG.M10_HAS_REGSLICE {4} \
   CONFIG.M11_HAS_REGSLICE {4} \
   CONFIG.M12_HAS_REGSLICE {4} \
   CONFIG.M13_HAS_REGSLICE {4} \
   CONFIG.M14_HAS_REGSLICE {4} \
   CONFIG.M15_HAS_REGSLICE {4} \
   CONFIG.M16_HAS_REGSLICE {4} \
   CONFIG.M17_HAS_REGSLICE {4} \
   CONFIG.M18_HAS_REGSLICE {4} \
   CONFIG.M19_HAS_REGSLICE {4} \
   CONFIG.M20_HAS_REGSLICE {4} \
   CONFIG.M21_HAS_REGSLICE {4} \
   CONFIG.M22_HAS_REGSLICE {4} \
   CONFIG.M23_HAS_REGSLICE {4} \
   CONFIG.M24_HAS_REGSLICE {4} \
   CONFIG.M25_HAS_REGSLICE {4} \
   CONFIG.M26_HAS_REGSLICE {4} \
   CONFIG.M27_HAS_REGSLICE {4} \
   CONFIG.M28_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {29} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
 ] $ps8_0_axi_periph

  # Create instance: rst_ps8_0_99M, and set properties
  set rst_ps8_0_99M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M ]

  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps_e_0 ]
  set_property -dict [ list \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {1} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_0_POLARITY {Default} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_10_POLARITY {Default} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_POLARITY {Default} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_12_POLARITY {Default} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_13_POLARITY {Default} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_POLARITY {Default} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_POLARITY {Default} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_POLARITY {Default} \
   CONFIG.PSU_MIO_17_DIRECTION {inout} \
   CONFIG.PSU_MIO_17_POLARITY {Default} \
   CONFIG.PSU_MIO_18_DIRECTION {in} \
   CONFIG.PSU_MIO_18_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_18_POLARITY {Default} \
   CONFIG.PSU_MIO_18_SLEW {fast} \
   CONFIG.PSU_MIO_19_DIRECTION {out} \
   CONFIG.PSU_MIO_19_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_19_POLARITY {Default} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_1_POLARITY {Default} \
   CONFIG.PSU_MIO_20_DIRECTION {inout} \
   CONFIG.PSU_MIO_20_POLARITY {Default} \
   CONFIG.PSU_MIO_21_DIRECTION {inout} \
   CONFIG.PSU_MIO_21_POLARITY {Default} \
   CONFIG.PSU_MIO_22_DIRECTION {inout} \
   CONFIG.PSU_MIO_22_POLARITY {Default} \
   CONFIG.PSU_MIO_23_DIRECTION {inout} \
   CONFIG.PSU_MIO_23_POLARITY {Default} \
   CONFIG.PSU_MIO_24_DIRECTION {inout} \
   CONFIG.PSU_MIO_24_POLARITY {Default} \
   CONFIG.PSU_MIO_25_DIRECTION {inout} \
   CONFIG.PSU_MIO_25_POLARITY {Default} \
   CONFIG.PSU_MIO_26_DIRECTION {inout} \
   CONFIG.PSU_MIO_26_POLARITY {Default} \
   CONFIG.PSU_MIO_27_DIRECTION {out} \
   CONFIG.PSU_MIO_27_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_27_POLARITY {Default} \
   CONFIG.PSU_MIO_28_DIRECTION {in} \
   CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_28_POLARITY {Default} \
   CONFIG.PSU_MIO_28_SLEW {fast} \
   CONFIG.PSU_MIO_29_DIRECTION {out} \
   CONFIG.PSU_MIO_29_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_29_POLARITY {Default} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_2_POLARITY {Default} \
   CONFIG.PSU_MIO_30_DIRECTION {in} \
   CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_30_POLARITY {Default} \
   CONFIG.PSU_MIO_30_SLEW {fast} \
   CONFIG.PSU_MIO_31_DIRECTION {inout} \
   CONFIG.PSU_MIO_31_POLARITY {Default} \
   CONFIG.PSU_MIO_32_DIRECTION {inout} \
   CONFIG.PSU_MIO_32_POLARITY {Default} \
   CONFIG.PSU_MIO_33_DIRECTION {inout} \
   CONFIG.PSU_MIO_33_POLARITY {Default} \
   CONFIG.PSU_MIO_34_DIRECTION {inout} \
   CONFIG.PSU_MIO_34_POLARITY {Default} \
   CONFIG.PSU_MIO_35_DIRECTION {inout} \
   CONFIG.PSU_MIO_35_POLARITY {Default} \
   CONFIG.PSU_MIO_36_DIRECTION {inout} \
   CONFIG.PSU_MIO_36_POLARITY {Default} \
   CONFIG.PSU_MIO_37_DIRECTION {inout} \
   CONFIG.PSU_MIO_37_POLARITY {Default} \
   CONFIG.PSU_MIO_38_DIRECTION {inout} \
   CONFIG.PSU_MIO_38_POLARITY {Default} \
   CONFIG.PSU_MIO_39_DIRECTION {inout} \
   CONFIG.PSU_MIO_39_POLARITY {Default} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_POLARITY {Default} \
   CONFIG.PSU_MIO_40_DIRECTION {inout} \
   CONFIG.PSU_MIO_40_POLARITY {Default} \
   CONFIG.PSU_MIO_41_DIRECTION {inout} \
   CONFIG.PSU_MIO_41_POLARITY {Default} \
   CONFIG.PSU_MIO_42_DIRECTION {inout} \
   CONFIG.PSU_MIO_42_POLARITY {Default} \
   CONFIG.PSU_MIO_43_DIRECTION {inout} \
   CONFIG.PSU_MIO_43_POLARITY {Default} \
   CONFIG.PSU_MIO_44_DIRECTION {inout} \
   CONFIG.PSU_MIO_44_POLARITY {Default} \
   CONFIG.PSU_MIO_45_DIRECTION {in} \
   CONFIG.PSU_MIO_45_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_45_POLARITY {Default} \
   CONFIG.PSU_MIO_45_SLEW {fast} \
   CONFIG.PSU_MIO_46_DIRECTION {inout} \
   CONFIG.PSU_MIO_46_POLARITY {Default} \
   CONFIG.PSU_MIO_47_DIRECTION {inout} \
   CONFIG.PSU_MIO_47_POLARITY {Default} \
   CONFIG.PSU_MIO_48_DIRECTION {inout} \
   CONFIG.PSU_MIO_48_POLARITY {Default} \
   CONFIG.PSU_MIO_49_DIRECTION {inout} \
   CONFIG.PSU_MIO_49_POLARITY {Default} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_POLARITY {Default} \
   CONFIG.PSU_MIO_50_DIRECTION {inout} \
   CONFIG.PSU_MIO_50_POLARITY {Default} \
   CONFIG.PSU_MIO_51_DIRECTION {out} \
   CONFIG.PSU_MIO_51_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_51_POLARITY {Default} \
   CONFIG.PSU_MIO_52_DIRECTION {in} \
   CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_52_POLARITY {Default} \
   CONFIG.PSU_MIO_52_SLEW {fast} \
   CONFIG.PSU_MIO_53_DIRECTION {in} \
   CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_53_POLARITY {Default} \
   CONFIG.PSU_MIO_53_SLEW {fast} \
   CONFIG.PSU_MIO_54_DIRECTION {inout} \
   CONFIG.PSU_MIO_54_POLARITY {Default} \
   CONFIG.PSU_MIO_55_DIRECTION {in} \
   CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_55_POLARITY {Default} \
   CONFIG.PSU_MIO_55_SLEW {fast} \
   CONFIG.PSU_MIO_56_DIRECTION {inout} \
   CONFIG.PSU_MIO_56_POLARITY {Default} \
   CONFIG.PSU_MIO_57_DIRECTION {inout} \
   CONFIG.PSU_MIO_57_POLARITY {Default} \
   CONFIG.PSU_MIO_58_DIRECTION {out} \
   CONFIG.PSU_MIO_58_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_58_POLARITY {Default} \
   CONFIG.PSU_MIO_59_DIRECTION {inout} \
   CONFIG.PSU_MIO_59_POLARITY {Default} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_5_POLARITY {Default} \
   CONFIG.PSU_MIO_60_DIRECTION {inout} \
   CONFIG.PSU_MIO_60_POLARITY {Default} \
   CONFIG.PSU_MIO_61_DIRECTION {inout} \
   CONFIG.PSU_MIO_61_POLARITY {Default} \
   CONFIG.PSU_MIO_62_DIRECTION {inout} \
   CONFIG.PSU_MIO_62_POLARITY {Default} \
   CONFIG.PSU_MIO_63_DIRECTION {inout} \
   CONFIG.PSU_MIO_63_POLARITY {Default} \
   CONFIG.PSU_MIO_64_DIRECTION {out} \
   CONFIG.PSU_MIO_64_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_64_POLARITY {Default} \
   CONFIG.PSU_MIO_65_DIRECTION {out} \
   CONFIG.PSU_MIO_65_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_65_POLARITY {Default} \
   CONFIG.PSU_MIO_66_DIRECTION {out} \
   CONFIG.PSU_MIO_66_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_66_POLARITY {Default} \
   CONFIG.PSU_MIO_67_DIRECTION {out} \
   CONFIG.PSU_MIO_67_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_67_POLARITY {Default} \
   CONFIG.PSU_MIO_68_DIRECTION {out} \
   CONFIG.PSU_MIO_68_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_68_POLARITY {Default} \
   CONFIG.PSU_MIO_69_DIRECTION {out} \
   CONFIG.PSU_MIO_69_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_69_POLARITY {Default} \
   CONFIG.PSU_MIO_6_DIRECTION {out} \
   CONFIG.PSU_MIO_6_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_6_POLARITY {Default} \
   CONFIG.PSU_MIO_70_DIRECTION {in} \
   CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_70_POLARITY {Default} \
   CONFIG.PSU_MIO_70_SLEW {fast} \
   CONFIG.PSU_MIO_71_DIRECTION {in} \
   CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_71_POLARITY {Default} \
   CONFIG.PSU_MIO_71_SLEW {fast} \
   CONFIG.PSU_MIO_72_DIRECTION {in} \
   CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_72_POLARITY {Default} \
   CONFIG.PSU_MIO_72_SLEW {fast} \
   CONFIG.PSU_MIO_73_DIRECTION {in} \
   CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_73_POLARITY {Default} \
   CONFIG.PSU_MIO_73_SLEW {fast} \
   CONFIG.PSU_MIO_74_DIRECTION {in} \
   CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_74_POLARITY {Default} \
   CONFIG.PSU_MIO_74_SLEW {fast} \
   CONFIG.PSU_MIO_75_DIRECTION {in} \
   CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_75_POLARITY {Default} \
   CONFIG.PSU_MIO_75_SLEW {fast} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_76_POLARITY {Default} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_77_POLARITY {Default} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_7_POLARITY {Default} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_8_POLARITY {Default} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_POLARITY {Default} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Feedback Clk#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO0 MIO#I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#GPIO1 MIO#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
   CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#gpio0[13]#scl_out#sda_out#scl_out#sda_out#rxd#txd#gpio0[20]#gpio0[21]#gpio0[22]#gpio0[23]#gpio0[24]#gpio0[25]#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#gpio1[31]#gpio1[32]#gpio1[33]#gpio1[34]#gpio1[35]#gpio1[36]#gpio1[37]#gpio1[38]#sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]#gpio1[43]#gpio1[44]#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out} \
   CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.656006} \
   CONFIG.PSU__AFI0_COHERENCY {0} \
   CONFIG.PSU__AFI1_COHERENCY {0} \
   CONFIG.PSU__CAN1__GRP_CLK__ENABLE {0} \
   CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.988037} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.328003} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {64} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.999750} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.785446} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {14} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.997009} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.328003} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.999500} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {30} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__IOPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {188} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {45} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__RPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.999800} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {25} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {3} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
   CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
   CONFIG.PSU__DDRC__ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__BANK_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
   CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
   CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
   CONFIG.PSU__DDRC__CL {15} \
   CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
   CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \
   CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
   CONFIG.PSU__DDRC__CWL {14} \
   CONFIG.PSU__DDRC__DDR3L_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
   CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
   CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
   CONFIG.PSU__DDRC__DEEP_PWR_DOWN_EN {0} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
   CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
   CONFIG.PSU__DDRC__DQMAP_0_3 {0} \
   CONFIG.PSU__DDRC__DQMAP_12_15 {0} \
   CONFIG.PSU__DDRC__DQMAP_16_19 {0} \
   CONFIG.PSU__DDRC__DQMAP_20_23 {0} \
   CONFIG.PSU__DDRC__DQMAP_24_27 {0} \
   CONFIG.PSU__DDRC__DQMAP_28_31 {0} \
   CONFIG.PSU__DDRC__DQMAP_32_35 {0} \
   CONFIG.PSU__DDRC__DQMAP_36_39 {0} \
   CONFIG.PSU__DDRC__DQMAP_40_43 {0} \
   CONFIG.PSU__DDRC__DQMAP_44_47 {0} \
   CONFIG.PSU__DDRC__DQMAP_48_51 {0} \
   CONFIG.PSU__DDRC__DQMAP_4_7 {0} \
   CONFIG.PSU__DDRC__DQMAP_52_55 {0} \
   CONFIG.PSU__DDRC__DQMAP_56_59 {0} \
   CONFIG.PSU__DDRC__DQMAP_60_63 {0} \
   CONFIG.PSU__DDRC__DQMAP_64_67 {0} \
   CONFIG.PSU__DDRC__DQMAP_68_71 {0} \
   CONFIG.PSU__DDRC__DQMAP_8_11 {0} \
   CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
   CONFIG.PSU__DDRC__ECC {Disabled} \
   CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
   CONFIG.PSU__DDRC__ENABLE_LP4_SLOWBOOT {0} \
   CONFIG.PSU__DDRC__FGRM {1X} \
   CONFIG.PSU__DDRC__LPDDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LPDDR4_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LP_ASR {manual normal} \
   CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
   CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
   CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
   CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
   CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
   CONFIG.PSU__DDRC__SB_TARGET {15-15-15} \
   CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
   CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
   CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
   CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
   CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
   CONFIG.PSU__DDRC__T_FAW {30.0} \
   CONFIG.PSU__DDRC__T_RAS_MIN {33} \
   CONFIG.PSU__DDRC__T_RC {47.06} \
   CONFIG.PSU__DDRC__T_RCD {15} \
   CONFIG.PSU__DDRC__T_RP {15} \
   CONFIG.PSU__DDRC__VENDOR_PART {OTHERS} \
   CONFIG.PSU__DDRC__VREF {1} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
   CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane0} \
   CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
   CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
   CONFIG.PSU__DP__REF_CLK_FREQ {27} \
   CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk1} \
   CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
   CONFIG.PSU__ENET3__PTP__ENABLE {0} \
   CONFIG.PSU__ENET3__TSU__ENABLE {0} \
   CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
   CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT1__FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__FPGA_PL0_ENABLE {1} \
   CONFIG.PSU__GEM3_COHERENCY {0} \
   CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
   CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
   CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GT__LINK_SPEED {HBR} \
   CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
   CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
   CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC0__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT0__FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__FREQMHZ {100.000000} \
   CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
   CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
   CONFIG.PSU__PL_CLK0_BUF {TRUE} \
   CONFIG.PSU__PMU_COHERENCY {0} \
   CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
   CONFIG.PSU__PMU__GPI0__ENABLE {0} \
   CONFIG.PSU__PMU__GPI1__ENABLE {0} \
   CONFIG.PSU__PMU__GPI2__ENABLE {0} \
   CONFIG.PSU__PMU__GPI3__ENABLE {0} \
   CONFIG.PSU__PMU__GPI4__ENABLE {0} \
   CONFIG.PSU__PMU__GPI5__ENABLE {0} \
   CONFIG.PSU__PMU__GPO0__ENABLE {0} \
   CONFIG.PSU__PMU__GPO1__ENABLE {0} \
   CONFIG.PSU__PMU__GPO2__ENABLE {0} \
   CONFIG.PSU__PMU__GPO3__ENABLE {0} \
   CONFIG.PSU__PMU__GPO4__ENABLE {0} \
   CONFIG.PSU__PMU__GPO5__ENABLE {0} \
   CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
   CONFIG.PSU__PRESET_APPLIED {1} \
   CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;1|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;0|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;1|SATA0:NonSecure;1|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;1|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;1|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;0|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_GPV;FD700000;FD7FFFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|FPD;CCI_GPV;FD6E0000;FD6EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1} \
   CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
   CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__SATA__LANE0__ENABLE {0} \
   CONFIG.PSU__SATA__LANE1__ENABLE {1} \
   CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \
   CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SATA__REF_CLK_FREQ {125} \
   CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk3} \
   CONFIG.PSU__SAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP3__DATA_WIDTH {128} \
   CONFIG.PSU__SD1_COHERENCY {0} \
   CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
   CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
   CONFIG.PSU__SD1__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD1__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
   CONFIG.PSU__SD1__RESET__ENABLE {0} \
   CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
   CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
   CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
   CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
   CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
   CONFIG.PSU__UART1__BAUD_RATE {115200} \
   CONFIG.PSU__UART1__MODEM__ENABLE {0} \
   CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART1__PERIPHERAL__IO {EMIO} \
   CONFIG.PSU__USB0_COHERENCY {0} \
   CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
   CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
   CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
   CONFIG.PSU__USB0__RESET__ENABLE {0} \
   CONFIG.PSU__USB1__RESET__ENABLE {0} \
   CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
   CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
   CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
   CONFIG.PSU__USE__IRQ0 {1} \
   CONFIG.PSU__USE__M_AXI_GP0 {1} \
   CONFIG.PSU__USE__M_AXI_GP1 {0} \
   CONFIG.PSU__USE__M_AXI_GP2 {0} \
   CONFIG.PSU__USE__S_AXI_GP0 {1} \
   CONFIG.PSU__USE__S_AXI_GP1 {0} \
   CONFIG.PSU__USE__S_AXI_GP2 {0} \
   CONFIG.PSU__USE__S_AXI_GP3 {0} \
   CONFIG.SUBPRESET1 {Custom} \
 ] $zynq_ultra_ps_e_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_dma_in0/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_MM2S [get_bd_intf_pins axi_dma_in1/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_2_M_AXI_MM2S [get_bd_intf_pins axi_dma_in2/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S02_AXI]
  connect_bd_intf_net -intf_net axi_dma_in0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_in0/M_AXIS_MM2S] [get_bd_intf_pins dfx_decoupler_1/rp_data]
  connect_bd_intf_net -intf_net axi_dma_in0_M_AXI_S2MM [get_bd_intf_pins axi_dma_in0/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S03_AXI]
  connect_bd_intf_net -intf_net axi_dma_in1_M_AXIS_MM2S [get_bd_intf_pins axi_dma_in1/M_AXIS_MM2S] [get_bd_intf_pins dfx_decoupler_2/rp_data]
  connect_bd_intf_net -intf_net axi_dma_in1_M_AXI_S2MM [get_bd_intf_pins axi_dma_in1/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S04_AXI]
  connect_bd_intf_net -intf_net axi_dma_in2_M_AXIS_MM2S [get_bd_intf_pins axi_dma_in2/M_AXIS_MM2S] [get_bd_intf_pins dfx_decoupler_3/rp_data]
  connect_bd_intf_net -intf_net axi_dma_in2_M_AXI_S2MM [get_bd_intf_pins axi_dma_in2/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S05_AXI]
  connect_bd_intf_net -intf_net axi_dma_in3_M_AXIS_MM2S [get_bd_intf_pins axi_dma_in3/M_AXIS_MM2S] [get_bd_intf_pins dfx_decoupler_4/rp_data]
  connect_bd_intf_net -intf_net axi_dma_in3_M_AXI_MM2S [get_bd_intf_pins axi_dma_in3/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S06_AXI]
  connect_bd_intf_net -intf_net axi_dma_in3_M_AXI_S2MM [get_bd_intf_pins axi_dma_in3/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S10_AXI]
  connect_bd_intf_net -intf_net axi_dma_in4_M_AXIS_MM2S [get_bd_intf_pins axi_dma_in4/M_AXIS_MM2S] [get_bd_intf_pins dfx_decoupler_5/rp_data]
  connect_bd_intf_net -intf_net axi_dma_in4_M_AXI_MM2S [get_bd_intf_pins axi_dma_in4/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S07_AXI]
  connect_bd_intf_net -intf_net axi_dma_in4_M_AXI_S2MM [get_bd_intf_pins axi_dma_in4/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S11_AXI]
  connect_bd_intf_net -intf_net axi_dma_in5_M_AXIS_MM2S [get_bd_intf_pins axi_dma_in5/M_AXIS_MM2S] [get_bd_intf_pins dfx_decoupler_6/rp_data]
  connect_bd_intf_net -intf_net axi_dma_in5_M_AXI_MM2S [get_bd_intf_pins axi_dma_in5/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S08_AXI]
  connect_bd_intf_net -intf_net axi_dma_in5_M_AXI_S2MM [get_bd_intf_pins axi_dma_in5/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S12_AXI]
  connect_bd_intf_net -intf_net axi_dma_in6_M_AXIS_MM2S [get_bd_intf_pins axi_dma_in6/M_AXIS_MM2S] [get_bd_intf_pins dfx_decoupler_7/rp_data]
  connect_bd_intf_net -intf_net axi_dma_in6_M_AXI_MM2S [get_bd_intf_pins axi_dma_in6/M_AXI_MM2S] [get_bd_intf_pins axi_smc/S09_AXI]
  connect_bd_intf_net -intf_net axi_dma_in6_M_AXI_S2MM [get_bd_intf_pins axi_dma_in6/M_AXI_S2MM] [get_bd_intf_pins axi_smc/S13_AXI]
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net axis_switch1_M00_AXIS [get_bd_intf_pins axis_switch1/M00_AXIS] [get_bd_intf_pins dfx_decoupler_combo1/rp_IN1]
  connect_bd_intf_net -intf_net axis_switch1_M01_AXIS [get_bd_intf_pins axis_switch1/M01_AXIS] [get_bd_intf_pins dfx_decoupler_combo1/rp_IN2]
  connect_bd_intf_net -intf_net axis_switch1_M02_AXIS [get_bd_intf_pins axis_switch1/M02_AXIS] [get_bd_intf_pins dfx_decoupler_combo1/rp_IN3]
  connect_bd_intf_net -intf_net axis_switch1_M03_AXIS [get_bd_intf_pins axis_switch1/M03_AXIS] [get_bd_intf_pins dfx_decoupler_combo1/rp_IN4]
  connect_bd_intf_net -intf_net axis_switch1_M04_AXIS [get_bd_intf_pins axis_switch1/M04_AXIS] [get_bd_intf_pins dfx_decoupler_combo2/rp_IN1]
  connect_bd_intf_net -intf_net axis_switch1_M05_AXIS [get_bd_intf_pins axis_switch1/M05_AXIS] [get_bd_intf_pins dfx_decoupler_combo2/rp_IN2]
  connect_bd_intf_net -intf_net axis_switch1_M06_AXIS [get_bd_intf_pins axis_switch1/M06_AXIS] [get_bd_intf_pins dfx_decoupler_combo2/rp_IN3]
  connect_bd_intf_net -intf_net axis_switch1_M07_AXIS [get_bd_intf_pins axis_switch1/M07_AXIS] [get_bd_intf_pins dfx_decoupler_combo2/rp_IN4]
  connect_bd_intf_net -intf_net axis_switch1_M08_AXIS [get_bd_intf_pins axis_switch1/M08_AXIS] [get_bd_intf_pins dfx_decoupler_combo3/rp_IN1]
  connect_bd_intf_net -intf_net axis_switch1_M09_AXIS [get_bd_intf_pins axis_switch1/M09_AXIS] [get_bd_intf_pins dfx_decoupler_combo3/rp_IN2]
  connect_bd_intf_net -intf_net axis_switch1_M10_AXIS [get_bd_intf_pins axis_switch1/M10_AXIS] [get_bd_intf_pins dfx_decoupler_combo3/rp_IN3]
  connect_bd_intf_net -intf_net axis_switch1_M11_AXIS [get_bd_intf_pins axis_switch1/M11_AXIS] [get_bd_intf_pins dfx_decoupler_combo3/rp_IN4]
  connect_bd_intf_net -intf_net axis_switch1_M12_AXIS [get_bd_intf_pins axis_switch/S07_AXIS] [get_bd_intf_pins axis_switch1/M12_AXIS]
  connect_bd_intf_net -intf_net axis_switch1_M13_AXIS [get_bd_intf_pins axis_switch/S08_AXIS] [get_bd_intf_pins axis_switch1/M13_AXIS]
  connect_bd_intf_net -intf_net axis_switch1_M14_AXIS [get_bd_intf_pins axis_switch/S09_AXIS] [get_bd_intf_pins axis_switch1/M14_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M00_AXIS [get_bd_intf_pins axis_switch/M00_AXIS] [get_bd_intf_pins axis_switch1/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M01_AXIS [get_bd_intf_pins axis_switch/M01_AXIS] [get_bd_intf_pins axis_switch1/S01_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M02_AXIS [get_bd_intf_pins axis_switch/M02_AXIS] [get_bd_intf_pins axis_switch1/S02_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M03_AXIS [get_bd_intf_pins axis_switch/M03_AXIS] [get_bd_intf_pins axis_switch1/S03_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M04_AXIS [get_bd_intf_pins axis_switch/M04_AXIS] [get_bd_intf_pins axis_switch1/S04_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M05_AXIS [get_bd_intf_pins axis_switch/M05_AXIS] [get_bd_intf_pins axis_switch1/S05_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M06_AXIS [get_bd_intf_pins axis_switch/M06_AXIS] [get_bd_intf_pins axis_switch1/S06_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M07_AXIS [get_bd_intf_pins axi_dma_in0/S_AXIS_S2MM] [get_bd_intf_pins axis_switch/M07_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M08_AXIS [get_bd_intf_pins axi_dma_in1/S_AXIS_S2MM] [get_bd_intf_pins axis_switch/M08_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M09_AXIS [get_bd_intf_pins axi_dma_in2/S_AXIS_S2MM] [get_bd_intf_pins axis_switch/M09_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M10_AXIS [get_bd_intf_pins axi_dma_in3/S_AXIS_S2MM] [get_bd_intf_pins axis_switch/M10_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M11_AXIS [get_bd_intf_pins axi_dma_in4/S_AXIS_S2MM] [get_bd_intf_pins axis_switch/M11_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M12_AXIS [get_bd_intf_pins axi_dma_in5/S_AXIS_S2MM] [get_bd_intf_pins axis_switch/M12_AXIS]
  connect_bd_intf_net -intf_net axis_switch_M13_AXIS [get_bd_intf_pins axi_dma_in6/S_AXIS_S2MM] [get_bd_intf_pins axis_switch/M13_AXIS]
  connect_bd_intf_net -intf_net dfx_decoupler_1_s_data [get_bd_intf_pins dfx_decoupler_1/s_data] [get_bd_intf_pins pr1/data]
  connect_bd_intf_net -intf_net dfx_decoupler_1_s_score [get_bd_intf_pins axis_switch/S00_AXIS] [get_bd_intf_pins dfx_decoupler_1/s_score]
  connect_bd_intf_net -intf_net dfx_decoupler_2_s_axilite [get_bd_intf_pins dfx_decoupler_2/s_axilite] [get_bd_intf_pins pr2/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_2_s_data [get_bd_intf_pins dfx_decoupler_2/s_data] [get_bd_intf_pins pr2/data]
  connect_bd_intf_net -intf_net dfx_decoupler_2_s_score [get_bd_intf_pins axis_switch/S01_AXIS] [get_bd_intf_pins dfx_decoupler_2/s_score]
  connect_bd_intf_net -intf_net dfx_decoupler_3_s_axilite [get_bd_intf_pins dfx_decoupler_3/s_axilite] [get_bd_intf_pins pr3/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_3_s_data [get_bd_intf_pins dfx_decoupler_3/s_data] [get_bd_intf_pins pr3/data]
  connect_bd_intf_net -intf_net dfx_decoupler_3_s_score [get_bd_intf_pins axis_switch/S02_AXIS] [get_bd_intf_pins dfx_decoupler_3/s_score]
  connect_bd_intf_net -intf_net dfx_decoupler_4_s_axilite [get_bd_intf_pins dfx_decoupler_4/s_axilite] [get_bd_intf_pins pr4/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_4_s_data [get_bd_intf_pins dfx_decoupler_4/s_data] [get_bd_intf_pins pr4/data]
  connect_bd_intf_net -intf_net dfx_decoupler_4_s_score [get_bd_intf_pins axis_switch/S03_AXIS] [get_bd_intf_pins dfx_decoupler_4/s_score]
  connect_bd_intf_net -intf_net dfx_decoupler_5_s_axilite [get_bd_intf_pins dfx_decoupler_5/s_axilite] [get_bd_intf_pins pr5/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_5_s_data [get_bd_intf_pins dfx_decoupler_5/s_data] [get_bd_intf_pins pr5/data]
  connect_bd_intf_net -intf_net dfx_decoupler_5_s_score [get_bd_intf_pins axis_switch/S04_AXIS] [get_bd_intf_pins dfx_decoupler_5/s_score]
  connect_bd_intf_net -intf_net dfx_decoupler_6_s_axilite [get_bd_intf_pins dfx_decoupler_6/s_axilite] [get_bd_intf_pins pr6/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_6_s_data [get_bd_intf_pins dfx_decoupler_6/s_data] [get_bd_intf_pins pr6/data]
  connect_bd_intf_net -intf_net dfx_decoupler_6_s_score [get_bd_intf_pins axis_switch/S05_AXIS] [get_bd_intf_pins dfx_decoupler_6/s_score]
  connect_bd_intf_net -intf_net dfx_decoupler_7_s_axilite [get_bd_intf_pins dfx_decoupler_7/s_axilite] [get_bd_intf_pins pr7/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_7_s_data [get_bd_intf_pins dfx_decoupler_7/s_data] [get_bd_intf_pins pr7/data]
  connect_bd_intf_net -intf_net dfx_decoupler_7_s_score [get_bd_intf_pins axis_switch/S06_AXIS] [get_bd_intf_pins dfx_decoupler_7/s_score]
  connect_bd_intf_net -intf_net dfx_decoupler_combo1_s_IN1 [get_bd_intf_pins dfx_decoupler_combo1/s_IN1] [get_bd_intf_pins pr_combo_1/IN1]
  connect_bd_intf_net -intf_net dfx_decoupler_combo1_s_IN2 [get_bd_intf_pins dfx_decoupler_combo1/s_IN2] [get_bd_intf_pins pr_combo_1/IN2]
  connect_bd_intf_net -intf_net dfx_decoupler_combo1_s_IN3 [get_bd_intf_pins dfx_decoupler_combo1/s_IN3] [get_bd_intf_pins pr_combo_1/IN3]
  connect_bd_intf_net -intf_net dfx_decoupler_combo1_s_IN4 [get_bd_intf_pins dfx_decoupler_combo1/s_IN4] [get_bd_intf_pins pr_combo_1/IN4]
  connect_bd_intf_net -intf_net dfx_decoupler_combo1_s_OUT_r [get_bd_intf_pins axis_switch1/S07_AXIS] [get_bd_intf_pins dfx_decoupler_combo1/s_OUT_r]
  connect_bd_intf_net -intf_net dfx_decoupler_combo1_s_axilite [get_bd_intf_pins dfx_decoupler_combo1/s_axilite] [get_bd_intf_pins pr_combo_1/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_combo2_s_IN1 [get_bd_intf_pins dfx_decoupler_combo2/s_IN1] [get_bd_intf_pins pr_combo_2/IN1]
  connect_bd_intf_net -intf_net dfx_decoupler_combo2_s_IN2 [get_bd_intf_pins dfx_decoupler_combo2/s_IN2] [get_bd_intf_pins pr_combo_2/IN2]
  connect_bd_intf_net -intf_net dfx_decoupler_combo2_s_IN3 [get_bd_intf_pins dfx_decoupler_combo2/s_IN3] [get_bd_intf_pins pr_combo_2/IN3]
  connect_bd_intf_net -intf_net dfx_decoupler_combo2_s_IN4 [get_bd_intf_pins dfx_decoupler_combo2/s_IN4] [get_bd_intf_pins pr_combo_2/IN4]
  connect_bd_intf_net -intf_net dfx_decoupler_combo2_s_OUT_r [get_bd_intf_pins axis_switch1/S08_AXIS] [get_bd_intf_pins dfx_decoupler_combo2/s_OUT_r]
  connect_bd_intf_net -intf_net dfx_decoupler_combo2_s_axilite [get_bd_intf_pins dfx_decoupler_combo2/s_axilite] [get_bd_intf_pins pr_combo_2/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net dfx_decoupler_combo3_s_IN1 [get_bd_intf_pins dfx_decoupler_combo3/s_IN1] [get_bd_intf_pins pr_combo_3/IN1]
  connect_bd_intf_net -intf_net dfx_decoupler_combo3_s_IN2 [get_bd_intf_pins dfx_decoupler_combo3/s_IN2] [get_bd_intf_pins pr_combo_3/IN2]
  connect_bd_intf_net -intf_net dfx_decoupler_combo3_s_IN3 [get_bd_intf_pins dfx_decoupler_combo3/s_IN3] [get_bd_intf_pins pr_combo_3/IN3]
  connect_bd_intf_net -intf_net dfx_decoupler_combo3_s_IN4 [get_bd_intf_pins dfx_decoupler_combo3/s_IN4] [get_bd_intf_pins pr_combo_3/IN4]
  connect_bd_intf_net -intf_net dfx_decoupler_combo3_s_OUT_r [get_bd_intf_pins axis_switch1/S09_AXIS] [get_bd_intf_pins dfx_decoupler_combo3/s_OUT_r]
  connect_bd_intf_net -intf_net dfx_decoupler_combo3_s_axilite [get_bd_intf_pins dfx_decoupler_combo3/s_axilite] [get_bd_intf_pins pr_combo_3/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net pr1_score [get_bd_intf_pins dfx_decoupler_1/rp_score] [get_bd_intf_pins pr1/score]
  connect_bd_intf_net -intf_net pr2_score [get_bd_intf_pins dfx_decoupler_2/rp_score] [get_bd_intf_pins pr2/score]
  connect_bd_intf_net -intf_net pr3_score [get_bd_intf_pins dfx_decoupler_3/rp_score] [get_bd_intf_pins pr3/score]
  connect_bd_intf_net -intf_net pr4_score [get_bd_intf_pins dfx_decoupler_4/rp_score] [get_bd_intf_pins pr4/score]
  connect_bd_intf_net -intf_net pr5_score [get_bd_intf_pins dfx_decoupler_5/rp_score] [get_bd_intf_pins pr5/score]
  connect_bd_intf_net -intf_net pr6_score [get_bd_intf_pins dfx_decoupler_6/rp_score] [get_bd_intf_pins pr6/score]
  connect_bd_intf_net -intf_net pr7_score [get_bd_intf_pins dfx_decoupler_7/rp_score] [get_bd_intf_pins pr7/score]
  connect_bd_intf_net -intf_net pr_combo_1_OUT_r [get_bd_intf_pins dfx_decoupler_combo1/rp_OUT_r] [get_bd_intf_pins pr_combo_1/OUT_r]
  connect_bd_intf_net -intf_net pr_combo_2_OUT_r [get_bd_intf_pins dfx_decoupler_combo2/rp_OUT_r] [get_bd_intf_pins pr_combo_2/OUT_r]
  connect_bd_intf_net -intf_net pr_combo_3_OUT_r [get_bd_intf_pins dfx_decoupler_combo3/rp_OUT_r] [get_bd_intf_pins pr_combo_3/OUT_r]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M00_AXI [get_bd_intf_pins axi_dma_in0/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M01_AXI [get_bd_intf_pins axi_dma_in1/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M02_AXI [get_bd_intf_pins axi_dma_in2/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M03_AXI [get_bd_intf_pins axi_dma_in3/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M04_AXI [get_bd_intf_pins axi_dma_in4/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M05_AXI [get_bd_intf_pins axi_dma_in5/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M06_AXI [get_bd_intf_pins axi_dma_in6/S_AXI_LITE] [get_bd_intf_pins ps8_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M07_AXI [get_bd_intf_pins dfx_decoupler_1/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M08_AXI [get_bd_intf_pins axis_switch/S_AXI_CTRL] [get_bd_intf_pins ps8_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M09_AXI [get_bd_intf_pins axis_switch1/S_AXI_CTRL] [get_bd_intf_pins ps8_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M10_AXI [get_bd_intf_pins dfx_decoupler_1/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M11_AXI [get_bd_intf_pins dfx_decoupler_2/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M11_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M12_AXI [get_bd_intf_pins dfx_decoupler_3/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M12_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M13_AXI [get_bd_intf_pins dfx_decoupler_4/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M13_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M14_AXI [get_bd_intf_pins dfx_decoupler_5/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M14_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M15_AXI [get_bd_intf_pins dfx_decoupler_6/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M15_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M16_AXI [get_bd_intf_pins dfx_decoupler_7/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M16_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M17_AXI [get_bd_intf_pins dfx_decoupler_combo1/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M17_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M18_AXI [get_bd_intf_pins dfx_decoupler_combo2/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M18_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M19_AXI [get_bd_intf_pins dfx_decoupler_combo3/rp_axilite] [get_bd_intf_pins ps8_0_axi_periph/M19_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M20_AXI [get_bd_intf_pins dfx_decoupler_2/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M20_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M21_AXI [get_bd_intf_pins dfx_decoupler_3/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M21_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M22_AXI [get_bd_intf_pins dfx_decoupler_4/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M22_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M23_AXI [get_bd_intf_pins dfx_decoupler_5/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M23_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M24_AXI [get_bd_intf_pins dfx_decoupler_6/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M24_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M25_AXI [get_bd_intf_pins dfx_decoupler_7/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M25_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M26_AXI [get_bd_intf_pins dfx_decoupler_combo1/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M26_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M27_AXI [get_bd_intf_pins dfx_decoupler_combo2/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M27_AXI]
  connect_bd_intf_net -intf_net ps8_0_axi_periph_M28_AXI [get_bd_intf_pins dfx_decoupler_combo3/s_axi_reg] [get_bd_intf_pins ps8_0_axi_periph/M28_AXI]
  connect_bd_intf_net -intf_net s_axi_AXILiteS_1 [get_bd_intf_pins dfx_decoupler_1/s_axilite] [get_bd_intf_pins pr1/s_axi_AXILiteS]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_FPD [get_bd_intf_pins ps8_0_axi_periph/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_FPD]

  # Create port connections
  connect_bd_net -net rst_ps8_0_99M_peripheral_aresetn [get_bd_pins axi_dma_in0/axi_resetn] [get_bd_pins axi_dma_in1/axi_resetn] [get_bd_pins axi_dma_in2/axi_resetn] [get_bd_pins axi_dma_in3/axi_resetn] [get_bd_pins axi_dma_in4/axi_resetn] [get_bd_pins axi_dma_in5/axi_resetn] [get_bd_pins axi_dma_in6/axi_resetn] [get_bd_pins axi_smc/aresetn] [get_bd_pins axis_switch/aresetn] [get_bd_pins axis_switch/s_axi_ctrl_aresetn] [get_bd_pins axis_switch1/aresetn] [get_bd_pins axis_switch1/s_axi_ctrl_aresetn] [get_bd_pins dfx_decoupler_1/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_2/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_3/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_4/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_5/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_6/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_7/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_combo1/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_combo2/s_axi_reg_aresetn] [get_bd_pins dfx_decoupler_combo3/s_axi_reg_aresetn] [get_bd_pins pr1/s_axi_aresetn] [get_bd_pins pr2/s_axi_aresetn] [get_bd_pins pr3/s_axi_aresetn] [get_bd_pins pr4/s_axi_aresetn] [get_bd_pins pr5/s_axi_aresetn] [get_bd_pins pr6/s_axi_aresetn] [get_bd_pins pr7/s_axi_aresetn] [get_bd_pins pr_combo_1/s_axi_aresetn] [get_bd_pins pr_combo_2/s_axi_aresetn] [get_bd_pins pr_combo_3/s_axi_aresetn] [get_bd_pins ps8_0_axi_periph/ARESETN] [get_bd_pins ps8_0_axi_periph/M00_ARESETN] [get_bd_pins ps8_0_axi_periph/M01_ARESETN] [get_bd_pins ps8_0_axi_periph/M02_ARESETN] [get_bd_pins ps8_0_axi_periph/M03_ARESETN] [get_bd_pins ps8_0_axi_periph/M04_ARESETN] [get_bd_pins ps8_0_axi_periph/M05_ARESETN] [get_bd_pins ps8_0_axi_periph/M06_ARESETN] [get_bd_pins ps8_0_axi_periph/M07_ARESETN] [get_bd_pins ps8_0_axi_periph/M08_ARESETN] [get_bd_pins ps8_0_axi_periph/M09_ARESETN] [get_bd_pins ps8_0_axi_periph/M10_ARESETN] [get_bd_pins ps8_0_axi_periph/M11_ARESETN] [get_bd_pins ps8_0_axi_periph/M12_ARESETN] [get_bd_pins ps8_0_axi_periph/M13_ARESETN] [get_bd_pins ps8_0_axi_periph/M14_ARESETN] [get_bd_pins ps8_0_axi_periph/M15_ARESETN] [get_bd_pins ps8_0_axi_periph/M16_ARESETN] [get_bd_pins ps8_0_axi_periph/M17_ARESETN] [get_bd_pins ps8_0_axi_periph/M18_ARESETN] [get_bd_pins ps8_0_axi_periph/M19_ARESETN] [get_bd_pins ps8_0_axi_periph/M20_ARESETN] [get_bd_pins ps8_0_axi_periph/M21_ARESETN] [get_bd_pins ps8_0_axi_periph/M22_ARESETN] [get_bd_pins ps8_0_axi_periph/M23_ARESETN] [get_bd_pins ps8_0_axi_periph/M24_ARESETN] [get_bd_pins ps8_0_axi_periph/M25_ARESETN] [get_bd_pins ps8_0_axi_periph/M26_ARESETN] [get_bd_pins ps8_0_axi_periph/M27_ARESETN] [get_bd_pins ps8_0_axi_periph/M28_ARESETN] [get_bd_pins ps8_0_axi_periph/S00_ARESETN] [get_bd_pins rst_ps8_0_99M/peripheral_aresetn]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0 [get_bd_pins axi_dma_in0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_in0/m_axi_s2mm_aclk] [get_bd_pins axi_dma_in0/s_axi_lite_aclk] [get_bd_pins axi_dma_in1/m_axi_mm2s_aclk] [get_bd_pins axi_dma_in1/m_axi_s2mm_aclk] [get_bd_pins axi_dma_in1/s_axi_lite_aclk] [get_bd_pins axi_dma_in2/m_axi_mm2s_aclk] [get_bd_pins axi_dma_in2/m_axi_s2mm_aclk] [get_bd_pins axi_dma_in2/s_axi_lite_aclk] [get_bd_pins axi_dma_in3/m_axi_mm2s_aclk] [get_bd_pins axi_dma_in3/m_axi_s2mm_aclk] [get_bd_pins axi_dma_in3/s_axi_lite_aclk] [get_bd_pins axi_dma_in4/m_axi_mm2s_aclk] [get_bd_pins axi_dma_in4/m_axi_s2mm_aclk] [get_bd_pins axi_dma_in4/s_axi_lite_aclk] [get_bd_pins axi_dma_in5/m_axi_mm2s_aclk] [get_bd_pins axi_dma_in5/m_axi_s2mm_aclk] [get_bd_pins axi_dma_in5/s_axi_lite_aclk] [get_bd_pins axi_dma_in6/m_axi_mm2s_aclk] [get_bd_pins axi_dma_in6/m_axi_s2mm_aclk] [get_bd_pins axi_dma_in6/s_axi_lite_aclk] [get_bd_pins axi_smc/aclk] [get_bd_pins axis_switch/aclk] [get_bd_pins axis_switch/s_axi_ctrl_aclk] [get_bd_pins axis_switch1/aclk] [get_bd_pins axis_switch1/s_axi_ctrl_aclk] [get_bd_pins dfx_decoupler_1/aclk] [get_bd_pins dfx_decoupler_2/aclk] [get_bd_pins dfx_decoupler_3/aclk] [get_bd_pins dfx_decoupler_4/aclk] [get_bd_pins dfx_decoupler_5/aclk] [get_bd_pins dfx_decoupler_6/aclk] [get_bd_pins dfx_decoupler_7/aclk] [get_bd_pins dfx_decoupler_combo1/aclk] [get_bd_pins dfx_decoupler_combo2/aclk] [get_bd_pins dfx_decoupler_combo3/aclk] [get_bd_pins pr1/s_axi_aclk] [get_bd_pins pr2/s_axi_aclk] [get_bd_pins pr3/s_axi_aclk] [get_bd_pins pr4/s_axi_aclk] [get_bd_pins pr5/s_axi_aclk] [get_bd_pins pr6/s_axi_aclk] [get_bd_pins pr7/s_axi_aclk] [get_bd_pins pr_combo_1/s_axi_aclk] [get_bd_pins pr_combo_2/s_axi_aclk] [get_bd_pins pr_combo_3/s_axi_aclk] [get_bd_pins ps8_0_axi_periph/ACLK] [get_bd_pins ps8_0_axi_periph/M00_ACLK] [get_bd_pins ps8_0_axi_periph/M01_ACLK] [get_bd_pins ps8_0_axi_periph/M02_ACLK] [get_bd_pins ps8_0_axi_periph/M03_ACLK] [get_bd_pins ps8_0_axi_periph/M04_ACLK] [get_bd_pins ps8_0_axi_periph/M05_ACLK] [get_bd_pins ps8_0_axi_periph/M06_ACLK] [get_bd_pins ps8_0_axi_periph/M07_ACLK] [get_bd_pins ps8_0_axi_periph/M08_ACLK] [get_bd_pins ps8_0_axi_periph/M09_ACLK] [get_bd_pins ps8_0_axi_periph/M10_ACLK] [get_bd_pins ps8_0_axi_periph/M11_ACLK] [get_bd_pins ps8_0_axi_periph/M12_ACLK] [get_bd_pins ps8_0_axi_periph/M13_ACLK] [get_bd_pins ps8_0_axi_periph/M14_ACLK] [get_bd_pins ps8_0_axi_periph/M15_ACLK] [get_bd_pins ps8_0_axi_periph/M16_ACLK] [get_bd_pins ps8_0_axi_periph/M17_ACLK] [get_bd_pins ps8_0_axi_periph/M18_ACLK] [get_bd_pins ps8_0_axi_periph/M19_ACLK] [get_bd_pins ps8_0_axi_periph/M20_ACLK] [get_bd_pins ps8_0_axi_periph/M21_ACLK] [get_bd_pins ps8_0_axi_periph/M22_ACLK] [get_bd_pins ps8_0_axi_periph/M23_ACLK] [get_bd_pins ps8_0_axi_periph/M24_ACLK] [get_bd_pins ps8_0_axi_periph/M25_ACLK] [get_bd_pins ps8_0_axi_periph/M26_ACLK] [get_bd_pins ps8_0_axi_periph/M27_ACLK] [get_bd_pins ps8_0_axi_periph/M28_ACLK] [get_bd_pins ps8_0_axi_periph/S00_ACLK] [get_bd_pins rst_ps8_0_99M/slowest_sync_clk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins zynq_ultra_ps_e_0/saxihpc0_fpd_aclk]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins rst_ps8_0_99M/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0x00000000 -range 0x80000000 -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_LOW] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xC0000000 -range 0x20000000 -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_QSPI] -force
  assign_bd_address -offset 0xA0000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_dma_in0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_dma_in1/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_dma_in2/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_dma_in3/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_dma_in4/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_dma_in5/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0060000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axi_dma_in6/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0xA0090000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axis_switch1/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0xA0080000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs axis_switch/S_AXI_CTRL/Reg] -force
  assign_bd_address -offset 0xA0190000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr_combo_3/combo_score_i2/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0180000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr_combo_2/combo_score_i3/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0170000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr_combo_1/combo_score_i4/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0070000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_1/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA00A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_2/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA00B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_3/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA00C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_4/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA00D0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_5/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA00E0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_6/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA00F0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_7/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA01A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_combo1/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA01B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_combo2/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA01C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs dfx_decoupler_combo3/s_axi_reg/Reg] -force
  assign_bd_address -offset 0xA0100000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr1/loda_cardio_c1/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0110000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr2/loda_cardio_c2/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0120000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr3/loda_cardio_c3/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0130000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr4/loda_cardio_c4/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0140000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr5/loda_cardio_c5/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0150000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr6/loda_cardio_c6/s_axi_AXILiteS/Reg] -force
  assign_bd_address -offset 0xA0160000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs pr7/loda_cardio_c7/s_axi_AXILiteS/Reg] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in0/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in1/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in2/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in3/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in4/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in5/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]
  exclude_bd_addr_seg -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_DDR_HIGH]
  exclude_bd_addr_seg -offset 0xFF000000 -range 0x01000000 -target_address_space [get_bd_addr_spaces axi_dma_in6/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e_0/SAXIGP0/HPC0_LPS_OCM]


  # Restore current instance
  current_bd_instance $oldCurInst

  # Create PFM attributes
  set_property PFM_NAME {xilinx.com:xd:${overlay_name}:1.0} [get_files [current_bd_design].bd]


  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


