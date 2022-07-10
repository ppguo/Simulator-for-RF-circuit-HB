function [NM,NI] = hb_nonlinear_stamper(NLNELEM,n,k,Xn)
nln_size = size(NLNELEM,1);
NM = zeros((2*k+1)*n);
NI = zeros((2*k+1)*n,1);
for m = 1:(2*k+1)
    tmp_Xn = Xn((m-1)*n+1:m*n);
    M = zeros(n);
    I = zeros(n,1);
    for i = 1:nln_size
        tmp_D = NLNELEM(i,:);
        [M,I] = hb_stamp_MOSFET(M,I,tmp_Xn,tmp_D);
    end
    NM((m-1)*n+1:m*n,(m-1)*n+1:m*n)=M;
    NI((m-1)*n+1:m*n) = I;
end
