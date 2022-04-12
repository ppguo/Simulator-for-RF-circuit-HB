---
attachments: [equation.JPG, icon.png]
pinned: true
title: MNA equation builder
created: '2022-04-12T08:31:09.974Z'
modified: '2022-04-12T09:26:49.237Z'
---

# MNA equation builder
We build a program generates the following MNA equations from the input linear circuit netlist
<p align="center">
  <img src="@attachment/equation.JPG">
</p>

## Input
  A SPICE format netlist file
  * Resistor, Inductance, Mutual Inductance, Capacitor Independent Voltage and Current Source are supported
  * Subcircuit is supported
## Output
*  Matrix or Vector C,G,B,L,X
*  Specific meaning for each variable in X
*  Name of source in U
*  Specific meaning for each variable in Y


