# Source flows
source inputs/flow/common_steps.tcl
source inputs/flow/common_flows.tcl
source inputs/flow/genus_steps.tcl

# Source configs
source inputs/config/genus_config.tcl
source inputs/config/flow_config.tcl
source inputs/config/design_config.tcl

# Run synthesis flow
run_flow -flow synthesis -yaml inputs/config/setup.yaml
