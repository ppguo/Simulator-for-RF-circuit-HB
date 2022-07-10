function [sin_t] = generate_sin_signal(SRC,dt,n)
global V_DCAMP_ V_ACAMP_ V_SINFREQ_ V_SINPHASE_ 

V0=SRC(V_DCAMP_);
M=SRC(V_ACAMP_);
f=SRC(V_SINFREQ_);
T=1/f;
phase = SRC(V_SINPHASE_)/180*pi;
sin_t = [];
for i=1:n
    sin_t(i)=M*sin(dt*(i-1)*f*2*pi+phase)+V0;
end

end