function [DFTmtx] = gen_DFTmtx(n,k);
DFTmtx = zeros((2*k+1));
N = 2*k+1;
for i = -k:k
    value = -1j*2*pi*i/N;
    for m = 1:N
        DFTmtx((i+k)*n+1:(i+k+1)*n,(m-1)*n+1:m*n)=eye(n)*exp(value*(m-1))/N;
    end
end
end