function [new_M] = hb_stamp_Capacitor(old_M,D,k,w,n);
%STAMP_IND_VSOURCE : stamps entries corresponding to an independent voltage source.
%
%                    syntax :  [new_M,new_I,new_row] = stamp_ind_vsource(old_M,old_I,D)
%
%                    new_M,old_M are the new and old MNA matrices
%                    new_I,old_I,are the new and old current matrices (right hand side)
%                    D is the data vector corresponding to the source
%                    "new_row" is the row number corresponding to this new source
%                    (This number has to be returned to the main function so that 
%                     the row corresponding to this voltage source can be accessed later.)

global C_N1_ C_N2_ C_IC_ C_VALUE_
new_M=old_M;

n1_0 = D(C_N1_);
n2_0 = D(C_N2_);
n1 = n1_0;
n2 = n2_0;
cvalue = D(C_VALUE_);
for i = 1:(2*k+1)
    value = (i-k-1)*w*1j*cvalue;
    if n1_0>length(new_M),  new_M(n1,n1)=0;end;
    if n2_0>length(new_M),  new_M(n2,n2)=0;end;
    if (n1_0>0) & (n2_0>0)
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