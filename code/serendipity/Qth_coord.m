function M = Qth_coord(x,y,V,Q)
    % Generate coordinates of Q-th order
    % Simply multiply every GBC by every other GBC many times over
    % The order of the multiplied functions is generalized from Hackermack's paper

    k = size(V,2);

    C = MV_coord(x,y,V);
    
    orders = functionOrder(k,Q);

    M = C(:,orders(1,:));
    for i = 2:Q
        M = M .* C(:,orders(i,:));
    end
end