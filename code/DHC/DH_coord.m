function C = DH_coord(x,y,V)
    % Construct mean value coordinates

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
        [dps(:,i),cps(:,i),C(:,i)] = weight_fun_DHC(x,y,V,i);
    end

    % Normalize the result and set values at the vertices
    p = isnan(C); % Only the DH coordinate vertex is NaN in each coordinate
    C = C ./ repmat(sum(C,2), [1 k]); % Now all vertices are NaN in all coordinates
    C(isnan(C)) = 0;
    C(p) = 1;

    % Set coordinates at the right boundaries to 0 by checking the dot and cross products
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