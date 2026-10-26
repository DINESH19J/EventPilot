# 🚀 EventPilot: Priority-Aware Event Processing Controller Using Verilog HDL

<p align="center">
  <strong>A Digital Design and ASIC Physical Implementation Project</strong>
</p>

---

## 📌 Introduction

**EventPilot** is a digital event-processing controller designed using Verilog Hardware Description Language (HDL). It processes multiple event requests and selects an output according to priority-based decision logic.

The project demonstrates the journey from RTL design and functional verification to logic synthesis, physical design, routing, Static Timing Analysis (STA), and GDS layout generation with a design-rule check, using open-source digital-design tools and the SkyWater SKY130 HD standard-cell technology.

## 🎯 Project Objectives

- Design a priority-aware event-processing controller using Verilog HDL.
- Verify functional behavior through a dedicated testbench.
- Synthesize RTL into a mapped digital circuit.
- Implement the physical-design flow from floorplanning to detailed routing.
- Analyze setup and hold timing using Static Timing Analysis.
- Generate the final GDS layout and check it with the KLayout SKY130 DRC deck.
- Document the design flow, verification results, and implementation limitations.

## ⚙️ Design Overview

EventPilot accepts multiple event requests and produces an encoded output based on the controller's priority logic.

**Basic processing flow:**

```text
Event Requests
      |
      v
Priority-Based Processing Logic
      |
      v
Sequential Control and State Updates
      |
      v
Encoded Output
```

The implementation uses sequential digital logic and is verified using Verilog simulation.

## 🔄 ASIC Implementation Flow

```text
       Verilog RTL
            |
            v
    Testbench Simulation
            |
            v
      Logic Synthesis
            |
            v
       Floorplanning
            |
            v
         Placement
            |
            v
 Clock-Tree Synthesis (CTS)
            |
            v
 Power Distribution Network
            |
            v
      Global Routing
            |
            v
     Detailed Routing
            |
            v
 Static Timing Analysis (STA)
            |
            v
 GDS Generation (KLayout)
            |
            v
 DRC (KLayout SKY130 deck)
```

## 🛠️ Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| Verilog HDL | RTL design |
| Verilog Testbench | Functional verification |
| Yosys | Logic synthesis |
| OpenROAD | ASIC physical-design implementation |
| OpenSTA | Static Timing Analysis |
| SkyWater SKY130 HD | Standard-cell technology |
| KLayout (`pya`) | Layout viewing, GDS generation and DRC |

## 🧪 Verification and Implementation Status

- **Functional verification:** The recorded testbench completed 17 checks successfully.
- **Logic synthesis:** Completed.
- **Floorplanning and placement:** Completed.
- **Clock-tree synthesis:** Completed.
- **Power distribution network:** Completed.
- **Global routing:** Completed.
- **Detailed routing:** Completed; the saved router log reports zero violations in the final detailed-routing run.
- **Static Timing Analysis:** Initial timing reports are available for further verification.
- **GDS generation:** Completed with KLayout; `gds/eventpilot.gds` was generated from the routed design.
- **DRC:** The KLayout SKY130 deck reported 0 violations on the GDS.
- **Not performed:** LVS and Magic-based signoff DRC.

## 🧱 GDS Generation and DRC

OpenROAD and Yosys in this setup have no GDS writer, and the Magic SKY130 technology was not installed, so the GDS was produced with KLayout in batch mode (`pya`).

**Method:** the detailed-route DEF (`eventpilot_detailed_route.def`) and the SKY130 HD LEF were read with the KLayout SKY130 layer map (`sky130.lyt`). Each standard-cell abstract was then replaced with its real SKY130 HD cell GDS (`scripts/merge.py`).

**Output:** [`gds/eventpilot.gds`](gds/eventpilot.gds)

**Checks performed**
- Die size 100 × 100 µm, matching the DEF `DIEAREA`.
- 18 standard-cell instances, matching the DEF components.
- Front-end layers (diff, poly, nwell, licon, nsdm, psdm) present inside the cells.
- Routing layers li1 through met5 and the power-grid vias present.
- KLayout SKY130 DRC (`sky130.lydrc`): 0 violations ([`drc/eventpilot_drc.lyrdb`](drc/eventpilot_drc.lyrdb)). The deck was validated on the provided `test_violators.gds`, where it reported 48 violations.

**Not performed:** LVS and Magic-based signoff DRC. This is a KLayout DRC result, not a foundry signoff claim.

## 📂 Repository Contents

| File | Description |
|---|---|
| `eventpilot.v` | EventPilot RTL design |
| `eventpilot_tb.v` | Verilog testbench |
| `eventpilot_mapped.v` | Synthesized mapped netlist |
| `eventpilot_netlist.v` | Gate-level netlist |
| `eventpilot.sdc` | Timing constraints |
| `eventpilot_floorplan.tcl` | Floorplanning script |
| `eventpilot_place.tcl` | Placement script |
| `eventpilot_pdn.tcl` | Power distribution configuration |
| `run_global_route.tcl` | Global routing script |
| `run_detailed_route.tcl` | Detailed routing script |
| `sta.tcl` | Static Timing Analysis script |
| `eventpilot_detailed_route.def` | Detailed-routing design database |
| `sta_report.txt` | Earlier STA report |
| `sta_post_route.log` | Post-route STA execution log |
| `SS_STA_Report.txt` | SS-labeled timing report |
| `FF_STA_Report.txt` | FF-labeled timing report |
| `TT_STA_Report.txt` | TT-labeled timing report |
| `gds/eventpilot.gds` | Final layout generated from the detailed-route DEF with KLayout and the SKY130 HD cell GDS |
| `drc/eventpilot_drc.lyrdb` | KLayout SKY130 DRC report (0 violations) |
| `scripts/merge.py` | DEF-to-GDS script that merges the real standard-cell GDS |
| `scripts/def2gds.py` | First-pass DEF-to-GDS script (routing and pins only) |
| `scripts/cell_gds.list` | List of SKY130 HD cell GDS files used by the merge |
| `scripts/ep_clean.lef` | Cleaned combined LEF used for the DEF read |

## 📊 Project Documentation

The [`docs/`](docs/) directory contains the implementation screenshots, explanations, and timing reports.

- **Screenshots and Physical-Design Walkthrough:** see [`docs/`](docs/) (screenshots document)
- **Pre-STA and Post-STA Reports:** see [`docs/reports/`](docs/reports/)

## 🎓 Applications

Priority-aware event processing is relevant to digital control systems where multiple requests may need to be handled according to priority.

Potential application areas include:
- Interrupt and request arbitration.
- Digital control systems.
- Event-handling controllers.
- Educational ASIC design and verification.

These are potential application areas, not claims that EventPilot has already been deployed in a real-world system.

## 👨‍💻 Project Information

**Project Name:** EventPilot  
**Design Language:** Verilog HDL  
**Implementation Platform:** OpenROAD  
**Layout and DRC:** KLayout  
**Technology:** SkyWater SKY130 HD  

---

<p align="center">
  <strong>EventPilot — From RTL Design to ASIC Physical Implementation</strong>
</p>
