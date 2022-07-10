function [new_M] = hb_stamp_inductor(old_M,D,k,n,bc,w);
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

global L_N1_ L_N2_ L_VALUE_
new_M=old_M;
length_M=length(old_M);
n1_0 = D(L_N1_);
n2_0 = D(L_N2_);
n1 = n1_0;
n2 = n2_0;
L_value = D(L_VALUE_);
if n1_0>length_M,  new_M(n1,n1)=0;end;
if n2_0>length_M,  new_M(n2,n2)=0;end;
for i = 1:(2*k+1)
    value = (i-k-1)*w*1j*L_value;
    if n1_0>length(new_M),  new_M(n1,n1)=0;end;
    if n2_0>length(new_M),  new_M(n2,n2)=0;end;
    if (n1_0>0) & (n2_0>0)
        new_M(n1,bc) = 1;
        new_M(bc,n1) = 1;
        new_M(n2,bc) = -1;
        new_M(bc,n2) = -1;
    elseif (n2_0>0)
        new_M(n2,bc) = -1;
        new_M(bc,n2) = -1;
    elseif (n1_0>0)
        new_M(n1,bc) = 1;
        new_M(bc,n1) = 1;
    new_M(bc,bc) = value;
   
    end
    n1 = n1+n;
    n2 = n2+n;
    bc = bc+n;
end
end