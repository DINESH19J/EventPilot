read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/tech/sky130_fd_sc_hd.tlef

foreach f [split [read [open "/home/vsduser/Desktop/EventPilot/cell_lefs_fixed.txt" r]] "\n"] {
    if {$f ne ""} {
        read_lef "/home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/$f"
    }
}

read_liberty /home/vsduser/Desktop/EventPilot/corners/sky130_fd_sc_hd__ss_100C_1v60.lib
read_def /home/vsduser/Desktop/EventPilot/eventpilot_detailed_route.def
read_sdc /home/vsduser/Desktop/EventPilot/eventpilot.sdc

set_wire_rc -signal -layer met2
set_wire_rc -clock -layer met5
set_propagated_clock [all_clocks]
estimate_parasitics -placement

puts "===== SETUP (max) ====="
report_checks -path_delay max -format full_clock_expanded -digits 3
puts "===== HOLD (min) ====="
report_checks -path_delay min -format full_clock_expanded -digits 3
puts "===== SUMMARY ====="
report_wns
report_tns
report_worst_slack -max
report_worst_slack -min
report_clock_skew
report_check_types -max_slew -max_capacitance -violators
report_power
exit
