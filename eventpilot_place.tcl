source /home/vsduser/Desktop/EventPilot/eventpilot_floorplan.tcl

global_placement -density 0.30

detailed_placement

check_placement

write_def /home/vsduser/Desktop/EventPilot/eventpilot_placed.def

exit
