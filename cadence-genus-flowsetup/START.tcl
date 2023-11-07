# Write out flow template
write_flow_template -type block -tools {genus} -enable_feature $::env(features) -directory outputs

# Substitute process node into genus_config.tcl
source inputs/mmmc_config.pdk.tcl
puts Generating the genus_config.tcl file...
exec sed 's/\<\< PLACEHOLDER: PROCESS NODE \>\>/$PROCESS/' outputs/genus_config.template > outputs/genus_config.tcl
