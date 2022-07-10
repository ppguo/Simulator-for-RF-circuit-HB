function [new_M]=stamp_conductance(old_M,D);
%STAMP_CONDUCTANCE : Stamps conductances  into the MNA matrix
%
%                    syntax : [new_M]=stamp_conductance(old_M,D)
%
%                    new_M,old_M are self-explanatory
%                    D is the data vector corresponding to the conductance or resistance.

global C_VALUE_ C_N1_ C_N2_ C_IC_ 
new_M=old_M;
n1 = D(Y_N1_);
n2 = D(Y_N2_);

if n1>length(new_M),  new_M(n1,n1)=0;end;
if n2>length(new_M),  new_M(n2,n2)=0;end;

value=D(Y_VALUE_);

if (n1>0) & (n2>0),
  new_M(n1,n1) = new_M(n1,n1) + value;
  new_M(n1,n2) = new_M(n1,n2) - value;
  new_M(n2,n1) = new_M(n2,n1) - value;
  new_M(n2,n2) = new_M(n2,n2) + value;
elseif (n2>0)
  new_M(n2,n2) = new_M(n2,n2) + value;
elseif (n1>0) 
  new_M(n1,n1) = new_M(n1,n1) + value;
end



