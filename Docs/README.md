# EventPilot
### Design and Implementation of a Priority-Aware Event Processing Controller Using Verilog HDL

EventPilot is a digital controller designed using Verilog HDL to process event requests according to their priority. This repository documents the RTL design, functional verification, synthesis, physical implementation, static timing analysis, and GDS generation.

## Design Flow

**Verilog RTL → Testbench Simulation → Yosys Synthesis → Floorplanning → Placement → CTS → PDN → Global Routing → Detailed Routing → Post-Implementation STA → GDS Generation (KLayout) → DRC (KLayout SKY130 deck)**

## Project Documentation

The [`docs/`](docs/) directory contains the project documentation, implementation screenshots, timing analysis, and comparison reports.

### 📸 Implementation Screenshots
View the [`docs/screenshots/`](docs/screenshots/) documentation for screenshots and explanations covering:

- GTKWave simulation
- Yosys synthesis
- Pre-synthesis and post-synthesis comparison
- Pre-STA analysis
- Floorplanning
- Placement
- Clock-tree synthesis (CTS)
- Power distribution network (PDN)
- Global routing
- Detailed routing
- Post-STA analysis
- Final GDS layout and DRC result (KLayout)

### 📊 Static Timing Analysis (STA)

The STA documentation compares timing results across the available process corners:

- **SS:** Slow-Slow
- **TT:** Typical-Typical
- **FF:** Fast-Fast

The analysis includes setup slack, hold slack, and pre-STA versus post-STA comparisons where verified results are available.

### 📈 Graphs and Comparisons

The report graphs visualize the available setup and hold slack values across corners and implementation stages. Refer to the corresponding timing reports for the source values and analysis conditions.

### 📄 Reports

See [`docs/reports/`](docs/reports/) for the available STA reports and analysis files.

## GDS Generation and DRC

OpenROAD and Yosys in this setup have no GDS writer, and the Magic SKY130 technology was not installed. The GDS was therefore generated with KLayout in batch mode (`pya`).

**Method:** `eventpilot_detailed_route.def` and the SKY130 HD LEF were read with the KLayout SKY130 layer map (`sky130.lyt`). Each standard-cell abstract was then replaced with its real SKY130 HD cell GDS (see [`scripts/merge.py`](scripts/merge.py)).

**Output:** [`gds/eventpilot.gds`](gds/eventpilot.gds)

**Checks performed**
- Die size is 100 × 100 µm, matching the DEF `DIEAREA`.
- 18 standard-cell instances, matching the DEF component count.
- Front-end layers (diff, poly, nwell, licon, nsdm, psdm) are present inside the cells.
- Routing layers li1 through met5 and the power-grid vias are present.
- The KLayout SKY130 DRC deck (`sky130.lydrc`) reported 0 violations ([`drc/eventpilot_drc.lyrdb`](drc/eventpilot_drc.lyrdb)). The deck was validated on the provided `test_violators.gds`, where it reported 48 violations.

**Not performed:** LVS and Magic-based signoff DRC. The DRC result is from the KLayout deck and is not a foundry signoff claim.

## Project Status

- RTL, simulation, synthesis, floorplanning, placement, CTS, PDN, global routing and detailed routing are completed.
- STA reports are available in `docs/reports/` and in the repository root.
- A GDS has been generated from the routed design and checked with the KLayout SKY130 DRC deck (0 violations).
- LVS and signoff DRC have not been run.
