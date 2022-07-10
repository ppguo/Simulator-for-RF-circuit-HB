function [new_M]=hb_stamp_resistance(old_M,D,n,k)
%STAMP_RESISTANCE : Stamps resistances  into the MNA matrix
%
%                   syntax : [new_M]=stamp_resistance(old_M,D)
%
%                   new_M,old_M are self-explanatory
%                   D is the data vector corresponding to the conductance or resistance.

global R_N1_ R_N2_ R_ R_VALUE_;
new_M = old_M;
n1_0 = D(R_N1_);
n2_0 = D(R_N2_);
n1 = n1_0;
n2 = n2_0;
value=1/D(R_VALUE_);
for i = 1:(2*k+1)
    if n1_0>length(new_M),  new_M(n1,n1)=0;end;
    if n2_0>length(new_M),  new_M(n2,n2)=0;end;
    if (n1_0>0) && (n2_0>0)
        new_M(n1,n1) = new_M(n1,n1) + value;
        new_M(n1,n2) = new_M(n1,n2) - value;
        new_M(n2,n1) = new_M(n2,n1) - value;
        new_M(n2,n2) = new_M(n2,n2) + value;
    elseif (n2_0>0)
        new_M(n2,n2) = new_M(n2,n2) + value;
    elseif (n1_0>0)
        new_M(n1,n1) = new_M(n1,n1) + value;
    end
    n1 = n1+n;
    n2 = n2+n;
end
end