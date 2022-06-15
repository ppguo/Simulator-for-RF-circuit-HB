

# MNA equation builder
We build a program generates the following MNA equations from the input linear circuit netlist
<p align="center">
  <img src="https://github.com/ppguo/MNA-equation-Builder-for-SPICE/blob/main/attachments/equation.JPG">
</p>

## Input
  A SPICE format netlist file
  * MOSFET, Resistor, Inductance, Mutual Inductance, Capacitor Independent Voltage and Current Source are supported
  * Subcircuit is supported
## Output
*  Matrix or Vector C,G,B,L,X
*  Specific meaning for each variable in X
*  Name of source in U
*  Specific meaning for each variable in Y


