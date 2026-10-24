# EventPilot — Pre-STA vs Post-STA Comparison

## Overview

This section presents the Static Timing Analysis (STA) results for the EventPilot priority-aware event processing controller. The comparison examines setup slack and hold slack across available process corners and physical implementation stages.

The purpose is to understand how timing results change as the design progresses from a synthesized netlist to physical implementation.

## 1. Pre-STA Analysis

Pre-STA evaluates the synthesized design before physical interconnect parasitics are included in the timing analysis.

The available mapped-netlist results cover three process corners:

- **SS (Slow-Slow):** Represents a slow process corner.
- **TT (Typical-Typical):** Represents a typical process corner.
- **FF (Fast-Fast):** Represents a fast process corner.

### Pre-STA Results

| Process Corner | Setup Slack (ns) | Hold Slack (ns) |
|---|---:|---:|
| SS | 16.01 | 0.69 |
| TT | 16.90 | 0.23 |
| FF | 17.11 | 0.16 |

### Observations

- All listed setup and hold slack values are positive.
- SS has the lowest recorded setup slack at 16.01 ns.
- FF has the smallest recorded hold slack at 0.16 ns.
- The complete timing reports must be checked to confirm that all required paths meet timing constraints.

## 2. Post-STA Analysis

Post-STA evaluates timing at a later physical-design stage. Depending on the stage, interconnect parasitics may be estimated from placement or global routing.

### Available Post-STA Results

| Implementation Stage | Process Corner | Setup Slack (ns) | Hold Slack (ns) |
|---|---|---:|---:|
| Placement-estimated | SS | 16.25 | 0.76 |
| Global-route-estimated | SS | 16.05 | 0.73 |
| Global-route-estimated | FF | 17.19 | 0.21 |

A verified TT global-route result was not available for this comparison and is therefore omitted.

### Observations

- The available post-STA results show positive setup and hold slack.
- At the SS corner, setup slack changes from 16.01 ns in the mapped-netlist analysis to 16.25 ns in the placement-estimated analysis.
- SS hold slack changes from 0.69 ns to 0.76 ns between those stages.
- The global-route-estimated results differ from the placement-estimated results because the analysis stages and parasitic estimates differ.

These comparisons should be interpreted alongside the original STA reports and their constraints.

## 3. Graphical Comparison

The accompanying graphs visualize:

1. Pre-STA setup slack across SS, TT, and FF.
2. Pre-STA hold slack across SS, TT, and FF.
3. SS setup and hold slack before and after placement-estimated parasitics.
4. Available global-route-estimated setup and hold slack for SS and FF.

The graphs are intended to make differences between the available timing results easier to understand.

## 4. Conclusion

The available results provide a comparison of EventPilot timing slack across the listed process corners and implementation stages. Positive slack is encouraging for the reported checks, but it does not independently establish complete timing closure or signoff.

Final conclusions require verification of the raw timing reports, all required process corners, clock constraints, and the final parasitic analysis.

## Note

The values in this README are based on the results currently available for this project. Verify them against the original STA logs before using them as final signoff results.
