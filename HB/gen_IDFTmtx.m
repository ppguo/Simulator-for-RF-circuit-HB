function [IDFTmtx] = gen_IDFTmtx(n,k);
IDFTmtx = zeros((2*k+1));
N = 2*k+1;
for i = -k:k
    value = 1j*2*pi*(i+k)/N;
    for m = 1:N
        IDFTmtx((i+k)*n+1:(i+k+1)*n,(m-1)*n+1:m*n)=eye(n)*exp(value*(m-k-1));
    end
end
end