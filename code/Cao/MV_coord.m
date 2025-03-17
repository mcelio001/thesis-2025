function C = MV_coord(x,y,V)
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
        [dps(:,i),cps(:,i),C(:,i)] = weight_fun(x,y,V,i);
    end

    % Normalize the result and set values at the vertices
    p = isnan(C); % Only the MV coordinate vertex is NaN in each coordinate
    C = C ./ repmat(sum(C,2), [1 k]); % Now all vertices are NaN in all coordinates
    C(isnan(C)) = 0;
    C(p) = 1;

    % Set coordinates at the right boundaries to 0 by checking the dot and cross products
    for i = 1:k
        for j = mod(i:k+i-3, k) + 1
            C(and(dps(:,j) < 1e-6, abs(cps(:,j)) < 1e-6),i) = 0;
        end
    end
end