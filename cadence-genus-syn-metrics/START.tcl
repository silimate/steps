# Source flows and run report flow
read_db inputs/genus.db
source inputs/run_flow.tcl
run_flow -flow report_synth
write_metric -format csv -file outputs/metrics.csv
