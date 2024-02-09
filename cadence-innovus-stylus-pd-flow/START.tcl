# Read flow
read_flow inputs/flow.yaml

# Read design information from Genus
read_design inputs/dbs/genus.cdb [get_db current_design .name]

# Run implementation flow
run_flow -flow implementation
