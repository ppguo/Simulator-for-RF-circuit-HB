function [new_M] = hb_stamp_Capacitor_of_MOSFET(old_M,D,k,n,w);
%STAMP_MOSFET : stamps entries corresponding to an independent voltage source.
%
%                    syntax :  [new_M,new_I,new_row] = stamp_ind_vsource(old_M,old_I,D)
%
%                    new_M,old_M are the new and old MNA matrices
%                    new_I,old_I,are the new and old current matrices (right hand side)
%                    D is the data vector corresponding to the source
%                    "new_row" is the row number corresponding to this new source
%                    (This number has to be returned to the main function so that 
%                     the row corresponding to this voltage source can be accessed later.)

global  M_ND_ M_NG_ M_NS_ M_W_ M_L_  M_COX_  M_CJ0_ 
new_M=old_M;

nd =D(M_ND_);
ng = D(M_NG_);
ns = D(M_NS_);
wid = D(M_W_);
l = D(M_L_);
cox = D(M_COX_);
CJ0 = D(M_CJ0_);
Cg = cox*wid*l*0.5;

[new_M] = hb_stamp_C_of_MOSFET(new_M,k,w,n,nd,-1,CJ0);%add Cd
[new_M] = hb_stamp_C_of_MOSFET(new_M,k,w,n,ns,-1,CJ0);%add Cs
[new_M] = hb_stamp_C_of_MOSFET(new_M,k,w,n,ng,ns,Cg);%add Cgs
[new_M] = hb_stamp_C_of_MOSFET(new_M,k,w,n,ng,nd,Cg);%add Cgd
end