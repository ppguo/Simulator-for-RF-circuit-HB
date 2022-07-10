function [LINELEM,NLNELEM,INFO,NODES,LINNAME,NLNNAME,PRINTNV,PRINTBV,PRINTBI,PLOTNV,PLOTBV,PLOTBI] = parser(CIRC);
% parser - interpret contents of circuit description file
%          and return relevant data for further processing
%
% Inputs  : CIRC    = Circuit description file name (string)
%
% Outputs : LINELEM = Array of linear elements
%           NLNELEM = Array of nonlinear elements (MOSFET)
%           INFO    = Contains information about transient analysis
%           NODES   = Actual numbers ("names") of the nodes
%           LINNAME = Names of the linear elements
%           NLNNAME = Names of the nonlinear elements
%           PRINTNV  = Node voltages to be printed
%           PRINTBV  = Branch voltages to be printed
%                     Column 1: index of corresponding element
%                     Column 2: indicates element matrix (1 = LINELEM, 2 = NLNELEM)
%           PRINTBI  = Branch currents to be printed
%                     Column 1: index of corresponding element
%                     Column 2: indicates element matrix (1 = LINELEM, 2 = NLNELEM)
%           PLOTNV  = Node voltages to be plotted
%           PLOTBV  = Branch voltages to be plotted
%                     Column 1: index of corresponding element
%                     Column 2: indicates element matrix (1 = LINELEM, 2 = NLNELEM)
%           PLOTBI  = Branch currents to be plotted
%                     Column 1: index of corresponding element
%                     Column 2: indicates element matrix (1 = LINELEM, 2 = NLNELEM)
%
% Call    : [LINELEM,NLNELEM,INFO,NODES,LINNAME,NLNNAME,PRINTNV,PRINTBV,PRINTBI,PLOTNV,PLOTBV,PLOTBI] = parser(CIRC)
global V_DCAMP_ V_ACAMP_ V_SINFREQ_ V_SINPHASE_
cparse_init;
parser_init;

% EA's additions;
NLNELEM=[]; LINELEM=[];
INFO=[]; NODES=[];
NLNNAME=[]; LINNAME=[];
PRINTNV=[]; PRINTBV=[];
PRINTBI=[];
PLOTNV=[]; PLOTBV=[];
PLOTBI=[];

% do some error checking
if (nargin ~= 1)
  error('Error: Wrong number of input arguments, check help parser');
end
if (nargout ~= 12)
  error('Error: Wrong number of output arguments, check help parser');
end

% Call the C code
[ELEM,INFO,NODES,NAMES,PRINTNV,PRINTBV_OLD,PRINTBI_OLD,PLOTNV,PLOTBV_OLD,PLOTBI_OLD] = cparse(CIRC);
BOGUS_ = 0;
LINEAR_ = 1;
NONLINEAR_ = 2;
countLIN = 0;
countNLN = 0;
for i=1:size(ELEM,1),
  if (ELEM(i,TYPE_) == R_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = R_;
    LINELEM(countLIN,R_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,R_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,R_N2_)      = ELEM(i,N2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == Y_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = Y_;
    LINELEM(countLIN,Y_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,Y_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,Y_N2_)      = ELEM(i,N2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == C_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = C_;
    LINELEM(countLIN,C_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,C_IC_)      = ELEM(i,IC_);
    LINELEM(countLIN,C_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,C_N2_)      = ELEM(i,N2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == L_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = L_;
    LINELEM(countLIN,L_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,L_IC_)      = ELEM(i,IC_);
    LINELEM(countLIN,L_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,L_N2_)      = ELEM(i,N2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == S_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = S_;
    LINELEM(countLIN,S_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,S_IC_)      = ELEM(i,IC_);
    LINELEM(countLIN,S_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,S_N2_)      = ELEM(i,N2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == K_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = K_;
    LINELEM(countLIN,K_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,K_ELEM1_)   = ELEM(i,N1_);
    LINELEM(countLIN,K_ELEM2_)   = ELEM(i,N2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == W_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = W_;
    LINELEM(countLIN,W_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,W_ELEM1_)   = ELEM(i,N1_);
    LINELEM(countLIN,W_ELEM2_)   = ELEM(i,N2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == V_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = V_;
    LINELEM(countLIN,V_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,V_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,V_N2_)      = ELEM(i,N2_);
    LINELEM(countLIN,V_TYPE_)    = ELEM(i,DAC_);
    if (LINELEM(countLIN,V_TYPE_) == AC_)
      LINELEM(countLIN,V_PHASE_) = ELEM(i,PHASE_);
    elseif (LINELEM(countLIN,V_TYPE_) == PWL_)
      LINELEM(countLIN,V_POINTS_)  = ELEM(i,PWL_START_V_);
      for j = 1:2*ELEM(i,PWL_START_V_)
        LINELEM(countLIN,V_POINTS_ + j) = ELEM(i,PWL_START_V_ + j);
      end
    else
%       global V_DCAMP_ V_ACAMP_ V_SINFREQ_ V_SINPHASE_
      l = length(LINELEM(countLIN,:));
      if V_DCAMP_>0
          LINELEM(countLIN,V_DCAMP_)=ELEM(i,31);
          LINELEM(countLIN,V_ACAMP_)=ELEM(i,32);
          LINELEM(countLIN,V_SINFREQ_)=ELEM(i,33);
          LINELEM(countLIN,V_SINPHASE_)=ELEM(i,34);
      else
          LINELEM(countLIN,l+1)=ELEM(i,31);
          V_DCAMP_ = l+1;
          LINELEM(countLIN,l+2)=ELEM(i,32);
          V_ACAMP_ = l+2;
          LINELEM(countLIN,l+3)=ELEM(i,33);
          V_SINFREQ_ = l+3;
          LINELEM(countLIN,l+4)=ELEM(i,34);
          V_SINPHASE_ = l+4;
      end
    end
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == I_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = I_;
    LINELEM(countLIN,I_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,I_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,I_N2_)      = ELEM(i,N2_);
    LINELEM(countLIN,I_TYPE_)    = ELEM(i,DAC_);
    if (LINELEM(countLIN,I_TYPE_) == AC_)
      LINELEM(countLIN,I_PHASE_) = ELEM(i,PHASE_);
    elseif (LINELEM(countLIN,I_TYPE_) == PWL_)
      LINELEM(countLIN,I_POINTS_)  = ELEM(i,PWL_START_I_);
      for j = 1:2*ELEM(i,PWL_START_I_)
        LINELEM(countLIN,I_POINTS_ + j) = ELEM(i,PWL_START_I_ + j);
      end
    end
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == E_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = E_;
    LINELEM(countLIN,E_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,E_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,E_N2_)      = ELEM(i,N2_);
    LINELEM(countLIN,E_CN1_)     = ELEM(i,CN1_);
    LINELEM(countLIN,E_CN2_)     = ELEM(i,CN2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == F_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = F_;
    LINELEM(countLIN,F_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,F_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,F_N2_)      = ELEM(i,N2_);
    LINELEM(countLIN,F_SOURCE_IND_)  = ELEM(i,CN1_); % to be mapped
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == G_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = G_;
    LINELEM(countLIN,G_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,G_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,G_N2_)      = ELEM(i,N2_);
    LINELEM(countLIN,G_CN1_)     = ELEM(i,CN1_);
    LINELEM(countLIN,G_CN2_)     = ELEM(i,CN2_);
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == H_),
    countLIN = countLIN + 1;
    LINELEM(countLIN,TYPE_) = H_;
    LINELEM(countLIN,H_VALUE_)   = ELEM(i,VALUE_);
    LINELEM(countLIN,H_N1_)      = ELEM(i,N1_);
    LINELEM(countLIN,H_N2_)      = ELEM(i,N2_);
    LINELEM(countLIN,H_SOURCE_IND_)  = ELEM(i,CN1_); % to be mapped
    LINNAME(countLIN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  elseif (ELEM(i,TYPE_) == M_),
    countNLN = countNLN + 1;
    NLNELEM(countNLN,TYPE_) = M_;
    NLNELEM(countNLN,M_W_)       = ELEM(i,MOS_W_);
    NLNELEM(countNLN,M_L_)       = ELEM(i,MOS_L_);
    NLNELEM(countNLN,M_ND_)      = ELEM(i,MOS_ND_);
    NLNELEM(countNLN,M_NG_)      = ELEM(i,MOS_NG_);
    NLNELEM(countNLN,M_NS_)      = ELEM(i,MOS_NS_);
    NLNELEM(countNLN,M_TYPE_)    = ELEM(i,MOS_TYPE_);
    NLNELEM(countNLN,M_MID_)     = ELEM(i,MOS_MID_);
    NLNNAME(countNLN,:) = NAMES(i,:);
    ELEMNUM(i,1:2) = [countNLN,NONLINEAR_];
  elseif (ELEM(i,TYPE_) == '.'),
    MDLELEM(ELEM(i,MOD_ID_),MOD_ID_)       = ELEM(i,MOD_ID_);
    MDLELEM(ELEM(i,MOD_ID_),MOD_VT_)       = ELEM(i,MOD_VT_);
    MDLELEM(ELEM(i,MOD_ID_),MOD_MU_)       = ELEM(i,MOD_MU_);
    MDLELEM(ELEM(i,MOD_ID_),MOD_COX_)      = ELEM(i,MOD_COX_);
    MDLELEM(ELEM(i,MOD_ID_),MOD_LAMBDA_)   = ELEM(i,MOD_LAMBDA_);
    MDLELEM(ELEM(i,MOD_ID_),MOD_CJ0_)      = ELEM(i,MOD_CJ0_);
    ELEMNUM(i,1:2) = [0,BOGUS_];
%  elseif (ELEM(i,TYPE_) == N_),
%    countLIN = countLIN + 1;
%    LINELEM(countLIN,TYPE_) = N_;
%    LINELEM(countLIN,N_N1_)      = ELEM(i,N1_);
%    LINELEM(countLIN,N_N2_)      = ELEM(i,N2_);
%    LINELEM(countLIN,N_CN1_)     = ELEM(i,CN1_);
%    LINELEM(countLIN,N_CN2_)     = ELEM(i,CN2_);
%    LINNAME(countLIN,:) = NAMES(i,:);
%    ELEMNUM(i,1:2) = [countLIN,LINEAR_];
  end
end

% append the model parameters to the MOSFET line in NLNELEM
for i = 1:size(NLNELEM,1),
  index = NLNELEM(i,M_MID_);
  for j = M_MID_:(M_MID_+size(MDLELEM,2)-MOD_ID_-1),
    NLNELEM(i,j) = MDLELEM(index,j-M_MID_+MOD_ID_+1);
  end
end

% grind up the PRINTBV and PRINTBI lists to adapt to the given LINELEM and
% NLNELEM
for i = 1:size(PRINTBV_OLD,2),
  PRINTBV(i,1:2) = ELEMNUM(PRINTBV_OLD(i),1:2);
end
for i = 1:size(PRINTBI_OLD,2),
  PRINTBI(i,1:2) = ELEMNUM(PRINTBI_OLD(i),1:2);
end

% grind up the PLOTBV and PLOTBI lists to adapt to the given LINELEM and
% NLNELEM
for i = 1:size(PLOTBV_OLD,2),
  PLOTBV(i,1:2) = ELEMNUM(PLOTBV_OLD(i),1:2);
end
for i = 1:size(PLOTBI_OLD,2),
  PLOTBI(i,1:2) = ELEMNUM(PLOTBI_OLD(i),1:2);
end

% also change the IDs for the elements in the current controlled sources F and H
for i = 1:size(LINELEM,1),
  if (LINELEM(i,TYPE_) == F_),
    index = LINELEM(i,F_SOURCE_IND_);
    LINELEM(i,F_SOURCE_IND_) = ELEMNUM(index,1);
    LINELEM(i,F_SOURCE_MAT_) = ELEMNUM(index,2);
  elseif (LINELEM(i,TYPE_) == H_),
    index = LINELEM(i,F_SOURCE_IND_);
    LINELEM(i,H_SOURCE_IND_) = ELEMNUM(index,1);
    LINELEM(i,H_SOURCE_MAT_) = ELEMNUM(index,2);
  end
end
% flip some vectors
INFO = INFO';
NODES = NODES';
PRINTNV = PRINTNV';
PLOTNV = PLOTNV';
