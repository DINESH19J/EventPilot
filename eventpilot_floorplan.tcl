# EventPilot Physical Design - Floorplan

read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/tech/sky130_fd_sc_hd.tlef

read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/a21oi/sky130_fd_sc_hd__a21oi_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/clkinv/sky130_fd_sc_hd__clkinv_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/dfrtp/sky130_fd_sc_hd__dfrtp_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/mux2i/sky130_fd_sc_hd__mux2i_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/nand2/sky130_fd_sc_hd__nand2_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/nand3b/sky130_fd_sc_hd__nand3b_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/nor2/sky130_fd_sc_hd__nor2_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/o21ai/sky130_fd_sc_hd__o21ai_0.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/o2bb2ai/sky130_fd_sc_hd__o2bb2ai_1.lef
read_lef /home/vsduser/Desktop/skywater-pdk-libs-sky130_fd_sc_hd/cells/o41ai/sky130_fd_sc_hd__o41ai_1.lef

read_liberty /home/vsduser/Desktop/EventPilot/corners/sky130_fd_sc_hd__ss_100C_1v60.lib

read_verilog /home/vsduser/Desktop/EventPilot/eventpilot_mapped.v
link_design eventpilot

read_sdc /home/vsduser/Desktop/EventPilot/eventpilot.sdc

initialize_floorplan -die_area {0 0 100 100} -core_area {10 10 90 90} -site unithd

make_tracks

place_pins -hor_layers met3 -ver_layers met2

write_def /home/vsduser/Desktop/EventPilot/eventpilot_floorplan.def

report_design_area
