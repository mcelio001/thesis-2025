function [C2,pts] = interp(C,X,Y,V,Q)
    n = length(X);
    k = size(V,2);
    k2 = size(C,2);
    
    C2 = zeros(n,k2);
    
    if Q == 2
        for i = 1:k
            C2(:,i) = C(:,i) - C(:,k+i) - C(:,k+mod(i-2,k)+1);
            C2(:,k+i) = 4 * C(:,k+i);
        end
    elseif Q == 3
        for i = 1:k
            C2(:,i) = C(:,i) - (5/2) * (C(:,k+i) + C(:,2*k+mod(i-2,k)+1)) + ...
                (C(:,2*k+i) + C(:,k+mod(i-2,k)+1));
            C2(:,k+i) = (9/2) * (2*C(:,k+i) - C(:,2*k+i));
            C2(:,2*k+i) = (9/2) * (2*C(:,2*k+i) - C(:,k+i));
        end
        
        if k == 3
            temp = find(C(:,10) == max(C(:,10)));
            temp = temp(1);
            C2(:,10) = C(:,10) / max(C(:,10));
            for i = 1:9
                C2(:,i) = C2(:,i) - C2(temp,i)*C2(:,10);
            end
        end
    end
    
    pts = zeros(1,k2);
    count = 1;
    for i = 1:k
        vi1 = V(:,i);
        vi2 = V(:,mod(i,k)+1);
        for j = 1:Q
            vpt = vi1 + ((j-1)/Q) * (vi2 - vi1);
            dist = (X-vpt(1)).^2 + (Y-vpt(2)).^2;
            temp = find(dist == min(dist));
            pts(count) = temp(1);
            count = count + 1;
        end
    end
    if Q == 3 && k == 3
        temp = find(C2(:,10) == max(C2(:,10)));
        pts(10) = temp(1);
    end
end

% u = 5;
% 
% f = figure();
% trisurf(tr,X,Y,C2(:,u));
% hold on;
% scatter3(X(pts),Y(pts),C2(pts,u), '.', 'red', 'SizeData', 100);
% f.Color = '#FFFFFF';