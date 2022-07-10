function [new_I] = stamp_ind_csource(old_I,D);
%STAMP_IND_CSOURCE : Stamps entries corresponding to an  independent 
%                    current source into the "I" matrix.
%
%                    syntax: [new_I] = stamp_ind_csource(old_I,D)

global I_N1_ I_N2_ I_VALUE_
new_I=old_I;

n1 = D(I_N1_);
n2 = D(I_N2_);
value = D(I_VALUE_);
if n1>length(old_I), new_I(n1)=0;end;
if n2>length(old_I), new_I(n2)=0;end;

if (n1>0), new_I(n1) = new_I(n1) - value;end;
if (n2>0), new_I(n2) = new_I(n2) + value;end;
