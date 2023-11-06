foreach constraint_mode [all_constraint_modes] {
  foreach delay_corner [all_delay_corners] {
    puts "$constraint_mode $delay_corner"
  }
}
