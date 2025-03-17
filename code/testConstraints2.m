aa = zeros(size(X));

k = size(V,2);
[order,coeff] = functionOrder(k,Q);
coeff = coeff(1:2*k);
c_max = factorial(Q);

for i = 1:2*k
    t = (V(1,order(1,i))+V(1,order(2,i)))*C(:,i)*coeff(i)/c_max;
    aa = aa + t;
    %aa = aa + (V(1,i)+V(1,mod(i,k)+1))*C(:,i+k);
end

uu = aa - X;