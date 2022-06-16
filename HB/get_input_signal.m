function [all_time_points] = get_input_signal( SRC,delta_t )
% get_input_signal£¬ PWL

global V_VALUE_ V_POINTS_ 
voltage_input = SRC(V_VALUE_);
tmp_vol = voltage_input;
tmp_time = 0;
l = length(SRC);

all_time_points = [tmp_vol];
for i=(V_POINTS_+1):2:l
    k = (SRC(i+1)-tmp_vol)/(SRC(i)-tmp_time);
    num = (SRC(i)-tmp_time)/delta_t
    i_time_points = (1:num)*k*delta_t+ tmp_vol;
    all_time_points = [all_time_points,i_time_points];
    tmp_time = SRC(i);
    tmp_vol = SRC(i+1);
end
end
