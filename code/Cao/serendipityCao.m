function C = serendipityCao(x,y,V)
    k = size(V,2);
    
    M = Qth_coord(x,y,V,2);
    orders = functionOrder(k,2);
    k2 = size(M,2) - 2*k;
    orders = orders(:,2*k+1:end);
  
    A = zeros(k2,6);
    
    for i = 1:k2
        j1 = orders(1,i);
        j2 = orders(2,i);
    
        V_i1 = V(:,mod(j1-2,k)+1);
        V_i = V(:,j1);
        V_i2 = V(:,mod(j1,k)+1);
        V_j1 = V(:,mod(j2-2,k)+1);
        V_j = V(:,j2);
        V_j2 = V(:,mod(j2,k)+1);
    
        A(i,1) = signedArea(V_j,V_i,V_i2) / (2* signedArea(V_i1,V_i,V_i2));
        A(i,2) = signedArea(V_i1,V_j,V_i2) / signedArea(V_i1,V_i,V_i2);
        A(i,3) = signedArea(V_i1,V_i,V_j) / (2* signedArea(V_i1,V_i,V_i2));
        A(i,4) = signedArea(V_i,V_j,V_j2) / (2* signedArea(V_j1,V_j,V_j2));
        A(i,5) = signedArea(V_j1,V_i,V_j2) / signedArea(V_j1,V_j,V_j2);
        A(i,6) = signedArea(V_j1,V_j,V_i) / (2* signedArea(V_j1,V_j,V_j2));
    end
    
    C = M(:,1:2*k);
    
    for u = 1:k2
        i = orders(1,u);
        j = orders(2,u);
        i2 = mod(i-2,k) + 1;
        j2 = mod(j-2,k) + 1;
    
        C(:,i) = C(:,i) + M(:,2*k+u)*A(u,2);
        C(:,j) = C(:,j) + M(:,2*k+u)*A(u,5);
        C(:,k+i) = C(:,k+i) + M(:,2*k+u)*A(u,3);
        C(:,k+j) = C(:,k+j) + M(:,2*k+u)*A(u,6);
        C(:,k+i2) = C(:,k+i2) + M(:,2*k+u)*A(u,1);
        C(:,k+j2) = C(:,k+j2) + M(:,2*k+u)*A(u,4);
    end
end    