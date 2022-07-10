function [sin_list] = generate_sin_signal_list(LINELEM,dt,n)
global TYPE_ V_

lin_size = size(LINELEM,1);
sin_list = zeros(1,n);
for i = 1:lin_size
    tmp_D = LINELEM(i,:);
    if tmp_D(TYPE_)==V_
        if tmp_D(5)==0,
        else
            sin_list(i,:) = generate_sin_signal(tmp_D,dt,n);
        end
    end
end