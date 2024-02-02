#=========================================================================
# generate-results.tcl
#=========================================================================
# Write Genus results.
#
# Author : Alex Carsello, James Thomas
# Date   : July 14, 2020

if { $uniquify_with_design_name == True } {
  update_names -subdesign -force -prefix ${design_name}_
}

write_snapshot -directory outputs -tag final
write_design -innovus -basename outputs/design
write_sdf > outputs/design.sdf
write_spef > outputs/design.spef
write_name_mapping -hdl -hierarchical -initial -map_pins all -print_deleted -output output design.namemap
