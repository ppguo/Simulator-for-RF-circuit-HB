% cparse_init - contains short cut constants for *internal* use
%               with the C code parser compiled with cmex

global TYPE_ MAG_ VALUE_ PHASE_ IC_ DAC_ N1_ N2_ CN1_ CN2_ FNUM_
global MOS_MID_ MOS_W_ MOS_L_ MOS_N1_ MOS_N2_ MOS_N3_ MOS_TYPE_
global MOD_ID_ MOD_VT_ MOD_MU_ MOD_COX_ MOD_LAMBDA_ MOD_CJ0_
global M_MID_

% For the ELEM Vector
%! TYPE_  = 1; %! is being defined now in parser_init.m, MB
MAG_   = 2;
VALUE_ = 2;
PHASE_ = 3;
IC_    = 4;
DAC_   = 5;
N1_    = 6;
N2_    = 7;
CN1_   = 8;
CN2_   = 9;
FNUM_  = 10;

% for PWL independent sources
PWL_START_V_ = 8;
PWL_START_I_ = 8;

% for MOSFET
MOS_MID_    = 2;
MOS_W_      = 3;
MOS_L_      = 4;
MOS_ND_     = 5;
MOS_NG_     = 6;
MOS_NS_     = 7;
MOS_TYPE_   = 8;

M_MID_      = 8; %! from parser_init.m to avoid confusion; MB

% for Model  
MOD_ID_     = 2;
MOD_VT_     = 3;
MOD_MU_     = 4;
MOD_COX_    = 5;
MOD_LAMBDA_ = 6;
MOD_CJ0_    = 7;
