# Source flows and run synthesis optimization flow
read_db inputs/syn_map.db
source inputs/run_flow.tcl
run_flow -flow syn_opt
