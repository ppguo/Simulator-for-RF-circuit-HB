

# HB Analysis for RF Circuit
A MATLAB program to perform HB Analysis for RF circuit, main functions are:
  * a simple automatic parser (style is borrowed from CMU class)
  * Transient analysis
  * Harmonic Balance Analysis


## Input
  A SPICE-like format netlist file (demo is provided in ./circuit_example)
  * MOSFET(one level model), Resistor, Inductance, Mutual Inductance, Capacitor Independent Voltage and Current Source are supported
  
## Output
*  The state of each variable (mainly voltage) in circuit, both in time domian and Freq domain


## Todo list
*  Improve the parser
*  Improve the final plot

