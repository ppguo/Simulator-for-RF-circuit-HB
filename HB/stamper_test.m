function [F,J,I,new_row_list] = stamper_test(V_PWL,Xn,Xnf,delta_t)

global R_ M_ Y_ N_ C_ L_ S_ K_ W_ V_ I_ G_ E_ F_ H_ TYPE_ V_VALUE_

[LINELEM,NLNELEM,INFO,NODES,LINNAME,NLNNAME,PRINTNV,PRINTBV,PRINTBI,PLOTNV,PLOTBV,PLOTBI] = parser('buffer.hb');
lin_size = size(LINELEM,1);
D = LINELEM(1,:);
num = length(NODES);
M = zeros(num);
I = zeros(num,1);
% Vn = 1;
% In = 1;
% delta_t = 0.01;
% Vds  = 1;
% Vgs = 0.8;
% To do 
% initilization
% new row!
new_row_list = [];
for i = 1:lin_size
    tmp_D = LINELEM(i,:);
    switch(tmp_D(TYPE_))
        case{R_},
        [M] = stamp_resistance(M,tmp_D);
        case{Y_},
        [M] = stamp_resistance(M,tmp_D);
        case{C_},
        [M,I,new_row_list(i)] = stamp_Capacitor(M,I,tmp_D,Xnf,delta_t);
        case{L_},
        [M,I,new_row_list(i)] = stamp_inductor(M,I,tmp_D,Xnf,delta_t);
        case{I_},
        [I] = stamp_ind_csource(I,tmp_D);
    end
    if tmp_D(TYPE_)==V_
        if tmp_D(5)==0,
            [M,I,new_row_list(i)] = stamp_ind_vsource(M,I,tmp_D,1000);
        else
            [M,I,new_row_list(i)] = stamp_ind_vsource(M,I,tmp_D,V_PWL);
        end
    end
end

nln_size = size(NLNELEM,1);
for i = 1:nln_size
    tmp_D = NLNELEM(i,:);
    [M,I] = stamp_MOSFET(M,I,Xn,tmp_D);
end
J = M;
F = M * Xn - I;

end

