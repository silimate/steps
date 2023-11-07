# Write out flow template
write_flow_template -type block -tools {genus} -enable_feature $::env(features) -directory outputs
source inputs/mmmc_config.pdk.tcl
exec sed 's/<< PLACEHOLDER:\ PROCESS NODE >>/'\"$PROCESS\"'/' outputs/genus_config.template > outputs/genus_config.tcl
