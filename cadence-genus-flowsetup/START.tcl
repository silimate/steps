# Write out flow template
write_flow_template -type block -tools {genus} -enable_feature $::env(features) -directory outputs

# Substitute process node into genus_config.tcl
source inputs/mmmc_config.pdk.tcl
puts "Generating the genus_config.tcl file..."
exec sed "N;s/<< PLACEHOLDER: PROCESS NODE >>/$PROCESS/;s/\\(# HDL attributes.*\\)/\\1\\n  set_db init_hdl_search_path             inputs\\/rtl\\//" outputs/genus_config.template > outputs/genus_config.tcl
