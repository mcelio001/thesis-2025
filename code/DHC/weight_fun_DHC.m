function [dp,cp,z] = weight_fun_DHC(x,y,V,i)
    % Find the weight function on vertex i

    % Dot product and cross product function (for sine and cosine calculations)
    dotp = @(a,b)sum(a.*b);
    crossp = @(a,b) a(1,:).*b(2,:) - a(2,:).*b(1,:);

    k = size(V,2);
    pts = [x;y];

    % Vertices i-1, i, i+1
    vj1 = V(:,mod(i-2,k)+1);
    vi = V(:,i);
    vj2 = V(:,mod(i,k)+1);

    % Vectors to each vertex
    sj1 = vj1 - pts;
    si = vi - pts;
    sj2 = vj2 - pts;
    d1 = repmat(vi - vj1, [1 length(x)]);
    d2 = repmat(vi - vj2, [1 length(x)]);

    % Distance from vertex i

    % Dot product and cross product values; saved for boundary calculation reasons
    dp = dotp(si,sj2);
    cp = crossp(si,sj2);

    % Angles alpha_i-1, alpha_i; obtained through tangent properties
    beta = atan2(crossp(-sj1,d1),dotp(-sj1,d1));
    gamma = atan2(crossp(d2,-sj2),dotp(d2,-sj2));

    % Weight function value
    z = cot(beta) + cot(gamma);
end