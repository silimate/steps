# Source flows and run report flow
read_db inputs/genus.db
source inputs/run_flow.tcl
run_flow -flow report_synth

# Write and report metrics in different formats
write_metric -format csv -file outputs/metrics.csv
write_metric -format json -file outputs/metrics.json
report_metric -format html -file outputs/metrics.html
report_metric -format vivid -file outputs/metrics.vivid.html

# Timing breakdowns
report_timing -nworst 10 -output_format gtd > outputs/worst_paths.gtd

# PPA breakdowns
set fp [open outputs/ppa.txt w]
set insts [get_insts]
set fields { base_cell area slack power_dynamic power_internal power_leakage power_switching power_total is_black_box is_buffer is_combinational is_cw_component is_dont_touch is_fixed_mask is_flop is_genus_clock_gate is_integrated_clock_gating is_interface_timing is_inverter is_isolation is_isolation_cell is_latch is_level_shifter is_macro is_master_slave_flop is_master_slave_lssd_flop is_memory is_negative_level_sensitive is_pad is_phase_inverted is_physical is_positive_level_sensitive is_retention is_sequential is_spare is_tristate }
puts -nonewline $fp "insts "
puts $fp $insts
foreach field $fields {
  puts -nonewline $fp $field
  puts -nonewline $fp " "
  puts $fp [get_db $insts .$field -computed]
}
close $fp
