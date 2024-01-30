# Source flows
source inputs/flow/common_steps.tcl
source inputs/flow/common_flows.tcl
source inputs/flow/genus_steps.tcl
source inputs/config/genus_config.tcl
if { [file exists inputs/config/innovus_config.tcl] } {
  source inputs/config/innovus_config.tcl
}
source inputs/config/flow_config.tcl
source inputs/config/design_config.tcl

# Run block flow
run_flow -flow block
