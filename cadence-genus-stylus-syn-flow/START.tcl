# Source flows and run block flow
source inputs/flow/common_steps.tcl
source inputs/flow/common_flows.tcl
source inputs/flow/genus_steps.tcl
source inputs/config/genus_config.tcl
source inputs/config/flow_config.tcl
source inputs/config/design_config.tcl
puts "RUNNING BLOCK FLOW"
run_flow -flow block
puts "DONE RUNNING BLOCK FLOW"
