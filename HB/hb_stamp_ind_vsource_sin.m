function [new_M,new_I] = hb_stamp_ind_vsource_sin(old_M,old_I,D,k,n,bc,p);
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


%%To add Phase
global V_N1_ V_N2_ V_ V_VALUE_ V_ACAMP_
new_M=old_M;
new_I=old_I;
n1_0 = D(V_N1_);
n2_0 = D(V_N2_);
n1 = n1_0;
n2 = n2_0;
Vac = D(V_ACAMP_);
bc_np = bc +(p-1)*n;
bc_p = bc +(2*k+1-p)*n;
for i = 1:(2*k+1)
    if n1_0>length(new_M),  new_M(n1,n1)=0;end;
    if n2_0>length(new_M),  new_M(n2,n2)=0;end;
    if (n1_0>0) && (n2_0>0)
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
    end
    n1 = n1+n;
    n2 = n2+n;
    bc = bc+n;
end
new_I(bc_np)=1j/2*Vac; %this is for SIN
new_I(bc_p)=-1j/2*Vac;
end
