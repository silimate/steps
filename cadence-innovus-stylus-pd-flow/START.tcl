# Read flow
read_flow inputs/flow.yaml

# Read design information from Genus
read_db inputs/dbs/genus.cdb

# Run implementation flow
run_flow -flow implementation
