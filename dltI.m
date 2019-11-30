function P = dltI(x, y, type)

N = size(x);
N = N(1);

A = zeros(N*2, type);



 for i=1:2:(N*2-1)
    for j=1:type
        if j <= type/3
            A(i,j)   = y(ceil(i/2),j);
        end
        
        if j >= type/3+1 && j <= 2*type/3
            A(i+1,j) = y(ceil((i+1)/2), j-type/3);
        end  
        
        if j>=2*type/3 + 1
            A(i,j)   = -x(ceil(i/2), 1) * y(ceil(i/2),j- 2*type/3);
            A(i+1,j) = -x(ceil(i/2), 2) * y(ceil(i/2),j- 2*type/3);
        end
    end
 end

 
[~,~,V] = svd(A);
A = reshape(V(:,end),type/3,3)';

P = A
end