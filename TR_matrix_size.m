function [n] = TR_matrix_size(LINELEM,NLNELEM,NODES)

global L_ V_ C_ TYPE_
global M_ND_ M_NS_
lin_size = size(LINELEM,1);
nln_size = size(NLNELEM,1);
num = length(NODES);
n = num;

for i = 1:lin_size
    tmp_D = LINELEM(i,:);
    switch(tmp_D(TYPE_))
        case{L_},
            n = n+1;
        case{V_},
            n = n+1;
        case{C_},
            n = n+1;
    end
end

for i = 1:nln_size
    tmp_D = NLNELEM(i,:);
    nd = tmp_D(M_ND_);
    ns = tmp_D(M_NS_);
    n = n+2;% Cgd Cgs
    if nd>0,  n = n+1; end  %add Cd
    if ns>0,  n = n+1; end  %add Cs
end
end