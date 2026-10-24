# EventPilot PDN Configuration
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/tech/sky130_fd_sc_hd.tlef

foreach f [split [read [open "/home/vsduser/Desktop/EventPilot/cell_lefs_fixed.txt" r]] "\n"] {
    if {$f ne "" && [file extension $f] eq ".lef" && ![string match "*.magic.lef" $f]} {
        read_lef "/home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/$f"
    }
}

read_liberty /home/vsduser/Desktop/EventPilot/corners/sky130_fd_sc_hd__ss_100C_1v60.lib
read_def /home/vsduser/Desktop/EventPilot/eventpilot_cts.def
read_sdc /home/vsduser/Desktop/EventPilot/eventpilot.sdc

add_global_connection -net VDD -inst_pattern .* -pin_pattern VPWR -power
add_global_connection -net VSS -inst_pattern .* -pin_pattern VGND -ground
global_connect

set_voltage_domain -name CORE -power VDD -ground VSS
set_wire_rc -signal -layer met2
set_wire_rc -clock -layer met5

define_pdn_grid -name CORE_GRID -voltage_domains CORE
