function C = Wach_coord(x,y,V)
    if size(x,2) == 1
            x = x';
    end
    if size(y,2) == 1
        y = y';
    end
    n = size(x,2);
    k = size(V,2);
    C = zeros(n,k); % Coordinates
    dps = zeros(n,k); % Dot products
    cps = zeros(n,k); % Cross products
    
    % Find all weight functions
    for i = 1:k
        [dps(:,i),cps(:,i),C(:,i)] = weight_Wach(x,y,V,i);
    end
    
    C = C ./ repmat(sum(C,2), [1 k]);
    
    for i = 1:k
        vi = V(:,i);
    
        for j = mod(i:k+i-3, k) + 1
            C(and(dps(:,j) < 1e-6, abs(cps(:,j)) < 1e-6),i) = 0;
        end
        for j = mod(i-2:i-1, k) + 1
            if j == i
                vj = V(:,mod(j,k)+1);
            else
                vj = V(:,j);
            end
            dist_xy = sqrt((x-vj(1)).^2 + (y-vj(2)).^2) ./ norm(vi - vj);
            C(and(dps(:,j) < 1e-6, abs(cps(:,j)) < 1e-6),i) = ...
                dist_xy(and(dps(:,j) < 1e-6, abs(cps(:,j)) < 1e-6));
        end
    end
end