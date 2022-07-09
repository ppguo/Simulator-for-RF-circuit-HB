function [n] = hb_matrix_size(LINELEM,NODES)

global L_ V_ TYPE_
lin_size = size(LINELEM,1);
num = length(NODES);
n = num;

for i = 1:lin_size
    tmp_D = LINELEM(i,:);
    switch(tmp_D(TYPE_))
        case{L_},
            n = n+1;
        case{V_},
            n = n+1;
    end
end
end