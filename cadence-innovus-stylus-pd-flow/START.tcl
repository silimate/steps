# Read flow
read_flow inputs/flow.yaml

# Read design information from Genus
read_db inputs/dbs/genus.cdb/cmn/

# Run implementation flow
run_flow -flow implementation
