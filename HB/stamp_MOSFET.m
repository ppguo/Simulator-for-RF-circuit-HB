function [new_M,new_I] = stamp_MOSFET(old_M,old_I,Xn,D);
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

global M_TYPE_ M_ND_ M_NG_ M_NS_ M_W_ M_L_ M_VT_ M_MU_ M_COX_ M_LAMBDA_ M_CJ0_ NMOS_ PMOS_
new_M=old_M;
new_I=old_I;
length_M=length(old_M);
type = D(M_TYPE_);
nd =D(M_ND_);
ng = D(M_NG_);
ns = D(M_NS_);
w = D(M_W_);
l = D(M_L_);
Vt = D(M_VT_);
u = D(M_MU_);
cox = D(M_COX_);
lambda = D(M_LAMBDA_);
k = w / l * u * cox;
if ng>0 && ns>0,
    Vgs = Xn(ng)-Xn(ns);
elseif ng>0,
    Vgs = Xn(ng);
    else
    Vgs = -Xn(ns);
end
if nd>0 && ns>0,
    Vds = Xn(nd)-Xn(ns);
elseif nd>0,
    Vds = Xn(nd);
    else
    Vds = -Xn(ns);
end

if type == NMOS_
    if (Vgs > Vt) && (Vds < Vgs - Vt)
        Gm = k * Vds
        Gds = k * (Vgs - Vt - Vds)
        Ids = k * ((Vgs - Vt) * Vds -Vds*Vds/2)
    elseif (Vgs > Vt) && (Vds > Vgs -Vt)
        Gm = k * (Vgs-Vt) * (1 + lambda * Vds)
        Gds = k * 0.5 * (Vgs-Vt)^2  * lambda
        Ids = k * 0.5 *(Vgs-Vt)^2* (1 + lambda * Vds)
    end
else
    if (Vgs < Vt) && (Vds > Vgs - Vt)
        Gm = -k * Vds;
        Gds = -k * (Vgs - Vt - Vds);
        Ids = -k * ((Vgs - Vt) * Vds -Vds*Vds/2);
    elseif (Vgs < Vt) && (Vds < Vgs -Vt)
        Gm = -k * (Vgs-Vt) * (1 - lambda * Vds);
        Gds = k * 0.5 * (Vgs-Vt)^2  * lambda;
        Ids = -k * 0.5 *(Vgs-Vt)^2* (1 - lambda * Vds);
    end
end

if nd>length_M,  new_M(nd,nd)=0;end
if ng>length_M,  new_M(ng,ng)=0;end
if ns>length_M,  new_M(ns,ns)=0;end
length_M=length(new_M);


if (type == NMOS_ && Vgs > Vt) || (type == PMOS_ && Vgs < Vt)
    In = Ids-Gm*Vgs-Gds*Vds
    if (nd > 0)
        new_M(nd,nd) = new_M(nd,nd)+Gds;
        if ns>0, new_M(nd,ns) = new_M(nd,ns)-Gds-Gm; end
        if ng>0, new_M(nd,ng) = new_M(nd,ng)+Gm;      end
        new_I(nd) = new_I(nd)-In;
    end
    if (ns > 0)
        new_M(ns,nd) = new_M(ns,nd)-Gds;
        if ns>0, new_M(ns,ns) = new_M(ns,ns)+Gds+Gm; end
        if ng>0, new_M(ns,ng) = new_M(ns,ng)-Gm;      end
        new_I(ns) = new_I(ns)+In
    end
end
end

