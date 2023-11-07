# Create analysis views for all constraint modes and delay corners
foreach constraint_mode [all_constraint_modes] {
  foreach delay_corner [all_delay_corners] {
    puts "Creating analysis view ${constraint_mode}_${delay_corner}..."
    create_analysis_view -name ${constraint_mode}_${delay_corner} -constraint_mode $constraint_mode -delay_corner $delay_corner
  }
}

# Try to infer the typical constraint mode if not specified
if {![info exists $typical_constraint_mode]} {
  if {[llength [all_constraint_modes]] == 1} {
    set typical_constraint_mode [lindex [all_constraint_modes] 0]
  } else {
    error "Need to specify typical_constraint_mode when multiple constraint modes exist"
  }
}

# Find setup and hold analysis views based on name (TODO: ensure this is correct)
set setup_analysis_views  [lsearch -all -regexp -inline [all_analysis_views] *(_tt)|(_ss)|(_slow)|(_cw)|(_rcw)|(_typ)*]
set hold_analysis_views   [lsearch -all -regexp -inline [all_analysis_views] *(_ff)|(_ss)|(_fast)|(_cb)|(_rcb)*]

# Set analysis view for MMMC
puts "Setting analysis view..."
set_analysis_view \
  -setup    { $setup_analysis_views } \
  -hold     { $hold_analysis_views } \
  -leakage  { ${typical_constraint_mode}_${typical_delay_corner} } \
  -dynamic  { ${typical_constraint_mode}_${typical_delay_corner} }
