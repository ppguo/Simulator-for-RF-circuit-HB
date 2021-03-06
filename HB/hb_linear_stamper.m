function [M,I] = hb_linear_stamper(LINELEM,NLNELEM,new_row_list,n,k,Base_Tone);
global R_ M_ Y_ N_ C_ L_ S_ K_ W_ V_ I_ G_ E_ F_ H_ TYPE_ V_VALUE_
lin_size = size(LINELEM,1);
M = zeros((2*k+1)*n);
I = zeros((2*k+1)*n,1);
w = Base_Tone*2*pi;
 for i = 1:lin_size
    tmp_D = LINELEM(i,:);
    switch(tmp_D(TYPE_))
        case{R_},
        [M] = hb_stamp_resistance(M,tmp_D,n,k);
        case{Y_},
        [M] = hb_stamp_resistance(M,tmp_D,n,k);
        case{C_},
        [M] = hb_stamp_Capacitor(M,tmp_D,k,w,n);
        case{L_},
        [M] = hb_stamp_inductor(M,tmp_D,k,n,new_row_list(i),w);
%         case{I_},
%         [I] = stamp_ind_csource(I,tmp_D);
    end
    if tmp_D(TYPE_)==V_
        if tmp_D(5)==0,
            [M,I] = hb_stamp_ind_vsource(M,I,tmp_D,k,n,new_row_list(i));
        else
%             [M,I] = hb_stamp_ind_vsource(M,I,tmp_D,k,n,new_row_list(i));
            [M,I] = hb_stamp_ind_vsource_sin(M,I,tmp_D,k,n,new_row_list(i),Base_Tone);
        end
    end
 end  
 
 %%stamp the parasite capacitor of MOSFET
 nln_size = size(NLNELEM,1);
 for i = 1:nln_size
     tmp_D = NLNELEM(i,:);
     [M] = hb_stamp_Capacitor_of_MOSFET(M,tmp_D,k,n,w);
 end
