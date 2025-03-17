function [dp,cp,z] = weight_fun(x,y,V,i)
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

    % Distance from vertex i
    denom = sqrt(si(1,:).^2 + si(2,:).^2);

    % Dot product and cross product values; saved for boundary calculation reasons
    dp = dotp(si,sj2);
    cp = crossp(si,sj2);

    % Angles alpha_i-1, alpha_i; obtained through tangent properties
    alpha1 = atan2(crossp(sj1,si),dotp(sj1,si));
    alpha2 = atan2(cp,dp);

    % Weight function value
    z = (tan(alpha1./2) + tan(alpha2./2))./denom;
end