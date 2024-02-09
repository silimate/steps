# Read flow
read_flow inputs/flow.yaml

# Read design information from Genus
source inputs/dbs/genus.cdb/cmn/*.mmmc.tcl
set_db init_netlist_files inputs/dbs/genus.cdb/cmn/*.v.gz
read_db inputs/dbs/genus.cdb/cmn/

# Run implementation flow
run_flow -flow implementation
