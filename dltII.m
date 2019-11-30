function P = dltII(x, y)

N = size(x);
N = N(1);

A = zeros(N*2, 9);

for i=1:2:(N*2-1)
% ============================
    A(i,1)   = y(ceil(i/2),1);
    
    A(i,2)   = y(ceil(i/2),2);
    
    A(i,3)   = y(ceil(i/2),4);
% ============================
    A(i+1,4) = y(ceil((i+1)/2),1);
    
    A(i+1,5) = y(ceil((i+1)/2),2);
    
    A(i+1,6) = y(ceil((i+1)/2),4);
% ============================    
    A(i,7)   = -x(ceil(i/2),1) * y(ceil(i/2),1);
    A(i+1,7) = -x(ceil(i/2),2) * y(ceil(i/2),1);
    
    A(i,8)   = -x(ceil(i/2),1) * y(ceil(i/2),2);
    A(i+1,8) = -x(ceil(i/2),2) * y(ceil(i/2),2);
    
    A(i,9)   = -x(ceil(i/2),1) * y(ceil(i/2),4);
    A(i+1,9) = -x(ceil(i/2),2) * y(ceil(i/2),4);
% ============================    
end

[~,~,V] = svd(A);
A = reshape(V(:,end),3,3)';
P = A

end