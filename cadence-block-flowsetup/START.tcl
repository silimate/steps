# Write out flow template
write_flow_template -type block -tools {genus innovus quantus tempus voltus lec} -enable_feature $::env(features) -directory outputs

# MMMC setup: add analysis views
source outputs/mmmc_config.tcl
set FH [open outputs/mmmc_config.tcl a]
puts $FH ""
puts $FH "###############################################################################"
puts $FH "### ANALYSIS VIEWS"
puts $FH "###############################################################################"
set analysis_view_is_setup_list   ""
set analysis_view_is_hold_list    ""
set analysis_view_is_dynamic_list ""
set analysis_view_is_leakage_list ""
foreach name [dict keys [get_flow_config analysis_views]] {
  puts $FH "create_analysis_view \\"
  puts $FH "  -name $name \\"
  puts $FH "  -constraint_mode [get_flow_config -quiet analysis_views $name constraint_mode] \\"
  if {![string is space [get_flow_config -quiet analysis_views $name power_modes]]} {
    puts $FH "  -power_modes [get_flow_config -quiet analysis_views $name power_modes] \\"
  }
  puts $FH "  -delay_corner [get_flow_config -quiet analysis_views $name delay_corner]"
  #- Sort views by purpose
  if {[string is true -strict [get_flow_config -quiet analysis_views $name is_setup]]} {
    lappend analysis_view_is_setup_list $name
  }
  if {[string is true -strict [get_flow_config -quiet analysis_views $name is_hold]]} {
    lappend analysis_view_is_hold_list $name
  }
  if {[string is true -strict [get_flow_config -quiet analysis_views $name is_leakage]]} {
    lappend analysis_view_is_leakage_list $name
  }
  if {[string is true -strict [get_flow_config -quiet analysis_views $name is_dynamic]]} {
    lappend analysis_view_is_dynamic_list $name
  }
  puts $FH ""
}