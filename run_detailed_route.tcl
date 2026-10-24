read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/tech/sky130_fd_sc_hd.tlef

foreach f [split [read [open "/home/vsduser/Desktop/EventPilot/cell_lefs_fixed.txt" r]] "\n"] {
    if {$f ne ""} {
        read_lef "/home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/$f"
    }
}

read_liberty /home/vsduser/Desktop/EventPilot/corners/sky130_fd_sc_hd__ss_100C_1v60.lib

read_def /home/vsduser/Desktop/EventPilot/eventpilot_global_route.def
read_guides /home/vsduser/Desktop/EventPilot/eventpilot.guide
read_sdc /home/vsduser/Desktop/EventPilot/eventpilot.sdc

set_wire_rc -signal -layer met2
set_wire_rc -clock -layer met5
set_routing_layers -signal met1-met5 -clock met1-met5

puts "=== STARTING DETAILED ROUTING ==="

detailed_route \
    -output_drc /home/vsduser/Desktop/EventPilot/detailed_route_drc.rpt \
    -output_guide_coverage /home/vsduser/Desktop/EventPilot/guide_coverage.rpt \
    -save_guide_updates


puts "=== DETAILED ROUTING COMMAND FINISHED ==="

write_def /home/vsduser/Desktop/EventPilot/eventpilot_detailed_route.def

exit
