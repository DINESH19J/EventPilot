# EventPilot
### Design and Implementation of a Priority-Aware Event Processing Controller Using Verilog HDL

EventPilot is a digital controller designed using Verilog HDL to process event requests according to their priority. This repository documents the RTL design, functional verification, synthesis, physical implementation, and static timing analysis.

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

## Design Flow

**Verilog RTL → Testbench Simulation → Yosys Synthesis → Floorplanning → Placement → CTS → PDN → Global Routing → Detailed Routing → Post-Implementation STA**

## Project Status

This repository documents the implementation flow and the timing results available for EventPilot. Final signoff status, complete corner coverage, design-rule verification, and GDS generation should be confirmed from the corresponding tool outputs.
