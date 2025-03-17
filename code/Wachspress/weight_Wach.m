function [dp,cp,areas] = weight_Wach(X,Y,V,j)
    dotp = @(a,b)sum(a.*b);
    crossp = @(a,b) a(1,:).*b(2,:) - a(2,:).*b(1,:);

    n = length(X);
    k = size(V,2);

    v_j1 = V(:,mod(j-2,k)+1);
    v_i = V(:,j);
    v_j2 = V(:,mod(j,k)+1);
    
    areas1 = zeros(n,1);
    areas2 = zeros(n,1);
    
    aa = det([1 1 1; v_j1 v_i v_j2]);
    
    for i = 1:n
        areas1(i) = det([1 1 1; X(i) v_j1(1) v_i(1); Y(i) v_j1(2) v_i(2)]);
        areas2(i) = det([1 1 1; X(i) v_i(1) v_j2(1); Y(i) v_i(2) v_j2(2)]);
    end
    
    areas = 2 * aa ./ (areas1 .* areas2);

    pts = [X;Y];
    si = v_i - pts;
    sj2 = v_j2 - pts;

    % Dot product and cross product values; saved for boundary calculation reasons
    dp = dotp(si,sj2);
    cp = crossp(si,sj2);
end