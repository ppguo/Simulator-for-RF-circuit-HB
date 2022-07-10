% parser_init - contains short cut constants which should be used
%               for accessing the data contained in the output of
%               parser (see: help parser)

% disp('Short Cuts for Circuit Parsing Loaded')

global R_ M_ Y_ N_ C_ L_ S_ K_ W_ V_ I_ G_ E_ F_ H_
global TYPE_
global R_N1_ R_N2_ R_VALUE_
global Y_N1_ Y_N2_ Y_VALUE_
global C_N1_ C_N2_ C_VALUE_ C_IC_
global L_N1_ L_N2_ L_VALUE_ L_IC_
global K_ELEM1_ K_ELEM2_ K_VALUE_
global S_N1_ S_N2_ S_VALUE_ S_IC_
global W_ELEM1_ W_ELEM2_ W_VALUE_
global DC_ AC_ PWL_ SIN_
global V_N1_ V_N2_ V_VALUE_ V_TYPE_ V_POINTS_ V_PHASE_
global I_N1_ I_N2_ I_VALUE_ I_TYPE_ I_POINTS_ I_PHASE_
global E_VALUE_ E_N1_ E_N2_ E_CN1_ E_CN2_
global F_VALUE_ F_N1_ F_N2_ F_SOURCE_IND_ F_SOURCE_MAT_
global G_VALUE_ G_N1_ G_N2_ G_CN1_ G_CN2_
global H_VALUE_ H_N1_ H_N2_ H_SOURCE_IND_ H_SOURCE_MAT_
global M_TYPE_ M_ND_ M_NG_ M_NS_ M_W_ M_L_ M_VT_ M_MU_ M_COX_ M_LAMBDA_ M_CJ0_
global NMOS_ PMOS_
global METHOD_ TSTEP_ TSTOP_ ORDER_ AC_PPD_ AC_FSTART_ AC_FSTOP_
global FE_ BE_ TR_ AWE_ PRIMA_
global LSTYPE_ L_CIR_ S_CIR_


% element identifiers
R_ = abs('R');
M_ = abs('M');
Y_ = abs('Y');
N_ = abs('N');
C_ = abs('C');
L_ = abs('L');
S_ = abs('S');
K_ = abs('K');
W_ = abs('W');
V_ = abs('V');
I_ = abs('I');
G_ = abs('G');
E_ = abs('E');
F_ = abs('F');
H_ = abs('H');

%! General comments:
% X_VALUE_  = value of the element
% X_N1_     = node 1
% X_N2_     = node 2
% X_N3_     = node 3
% X_IC_     = initial condition (current, voltage, etc.)
% X_CN1_    = controlled node 1
% X_CN2_    = controlled node 2

% element type;
TYPE_       = 1; %! type ID for the element
% for resistors
R_VALUE_    = 2;
R_N1_       = 3;
R_N2_       = 4;
% for conductors
Y_VALUE_    = 2;
Y_N1_       = 3;
Y_N2_       = 4;
% for capacitors
C_VALUE_    = 2;
C_N1_       = 3;
C_N2_       = 4;
C_IC_       = 5; %! initial capacitor voltage
% for inductors
L_VALUE_    = 2;
L_N1_       = 3;
L_N2_       = 4;
L_IC_       = 5; %! initial inductor current
% for susceptors
S_VALUE_    = 2;
S_N1_       = 3;
S_N2_       = 4;
S_IC_	    = 5;
%S_IC_       = 5; %! initial susceptor current? well... must be tricky one.
% for mutual inductors
K_VALUE_    = 2;
K_ELEM1_       = 3;
K_ELEM2_       = 4;
% for mutual susceptors
W_VALUE_    = 2;
W_ELEM1_       = 3;
W_ELEM2_       = 4;
% independent sources
DC_         = 0;
AC_         = 1;
PWL_        = 2;
SIN_        = 3;
% for voltage sources
V_VALUE_    = 2;
V_N1_       = 3;
V_N2_       = 4;
V_TYPE_     = 5; %! DC_ AC_ PWL_
V_POINTS_   = 6;
V_PHASE_    = 6;
% for current sources
I_VALUE_    = 2;
I_N1_       = 3;
I_N2_       = 4;
I_TYPE_     = 5; %! DC_ AC_ PWL_
I_POINTS_   = 6;
I_PHASE_    = 6;
% for voltage controlled voltage sources
E_VALUE_    = 2;
E_N1_       = 3;
E_N2_       = 4;
E_CN1_      = 5;
E_CN2_      = 6;
% for current controlled current sources
F_VALUE_    = 2;
F_N1_       = 3;
F_N2_       = 4;
F_SOURCE_IND_   = 5; %! source (controlling) element index
F_SOURCE_MAT_   = 6; %! matrix, where to find source element data
                     %! 1 = LINELEM, 2 = NLNELEM
% for voltage controlled current sources
G_VALUE_    = 2;
G_N1_       = 3;
G_N2_       = 4;
G_CN1_      = 5;
G_CN2_      = 6;
% for current controlled voltage sources
H_VALUE_    = 2;
H_N1_       = 3;
H_N2_       = 4;
H_SOURCE_IND_   = 5; %! source (controlling) element index
H_SOURCE_MAT_   = 6; %! matrix, where to find source element data
                     %! 1 = LINELEM, 2 = NLNELEM
% for MOSFET
M_TYPE_     = 2; %! type of MOSFET; NMOS_ or PMOS_
M_ND_       = 3; %! drain node
M_NG_       = 4; %! gate node
M_NS_       = 5; %! source node
M_W_        = 6; %! width
M_L_        = 7; %! length
% and those from the .MODEL card
M_VT_       = 8; %! threshold voltage
M_MU_       = 9; %! mobility
M_COX_      = 10; %! gate oxide capacitance per area
M_LAMBDA_   = 11; %! channel-width modulator
M_CJ0_      = 12; %! junction capacitance

NMOS_       = 1; %! type ID for NMOS (-> M_TYPE_)
PMOS_       = 0; %! type ID for PMOS (-> M_TYPE_)
% Elements of the INFO vector
METHOD_    = 1; %! integration method
TSTEP_     = 2; %! internal timestep
TSTOP_     = 3; %! end time
ORDER_     = 4; %! order of model order reduction
AC_PPD_    = 5; %! evaluation points per decade
AC_FSTART_ = 6; %! lower evaluation frequency bound
AC_FSTOP_  = 7; %! upper evaluation frequency bound
LSTYPE_	   = 8; %! inductor/susceptor circuit indicator
% values for INFO(METHOD_) -> 0, if no transient analysis of any sort
FE_     = 1; %! Forward Euler
BE_	= 2; %! Backward Euler
TR_	= 3; %! Trapezoidal Rule
AWE_    = 4; %! Asymptotic Waveform Evaluation
PRIMA_  = 5; %! PRIMA (ask Altan what the acronym means)
% values for INFO(LSTYPE_)
L_CIR_  = 1;
S_CIR_  = 2;
