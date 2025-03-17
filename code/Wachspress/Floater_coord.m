function C2 = Floater_coord(X,Y,V,Q)
    n = length(X);
    k = size(V,2);
    
    C = MV_coord(X,Y,V);
    
    barys = zeros(n,3,k);
    
    for i = 1:k
        barys(:,:,i) = MV_coord(X,Y,[V(:,mod(i-2,k)+1) V(:,i) V(:,mod(i,k)+1)]);
    end
    
    C2 = zeros(n,k*Q);
    
    for i = 1:k
        C2(:,i) = C(:,i) .* barys(:,2,i).^(Q-1);
    end
    u = k + 1;
    for i = 1:k
        for j = 1:Q-1
            C2(:,j*k+i) = nchoosek(Q-1,j) * C(:,i) .* ...
                barys(:,3,i).^j .* barys(:,2,i).^(Q-1-j) + ...
                nchoosek(Q-1,j-1) * C(:,mod(i,k)+1) .*  ...
                barys(:,2,mod(i,k)+1).^(j-1) .* barys(:,1,mod(i,k)+1).^(Q-j);
            C2(:,j*k+i) = C2(:,j*k+i) / nchoosek(Q,j);
            u = u + 1;
        end
    end
end