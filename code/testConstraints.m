k = size(V,2);
[order,coeff] = functionOrder(k,Q);

n_ser = size(C,2);

order = order(:,1:n_ser);
coeff = coeff(:,1:n_ser);

checks = ones(length(X),(Q+1)*(Q+2)/2);
u = 2;
for N = 1:Q
    Monoms = 2*ones(N,N+1);
    Monoms(:,1:N) = Monoms(:,1:N) - tril(ones(N));
    Monoms = flip(Monoms,1);
    for i = 1:N+1
        for h = 1:N
            if Monoms(h,i) == 1
                checks(:,u) = checks(:,u) .* X;
            else
                checks(:,u) = checks(:,u) .* Y;
            end
        end
        u = u + 1;
    end
end


tests = zeros(length(X),(Q+1)*(Q+2)/2);
perms_index = perms(Q:-1:1);
c_max = factorial(Q);

for l = 1:n_ser
    tests(:,1) = tests(:,1) + C(:,l) * coeff(l);
end

u = 2;
for N = 1:Q
    Monoms = 2*ones(N,N+1);
    Monoms(:,1:N) = Monoms(:,1:N) - tril(ones(N));
    Monoms = flip(Monoms,1);

    for i = 1:N+1
        for l = 1:n_ser
            poly = 0;
            for j = 1:c_max
                mono = 1;
                for h = 1:N
                    mono = mono .* V(Monoms(h,i),order(perms_index(j,h),l));
                end
                mono = mono * coeff(l) / c_max;
                poly = poly + mono;
            end
            tests(:,u) = tests(:,u) + poly .* C(:,l);
        end
        u = u + 1;
    end
end


aaaal = sum(abs(checks - tests) > 1e-5);

% for i = 1:n_ser
%     temp = order(:,i);
%     temp = perms(temp);
%     temp = unique(temp,'rows');
% 
%     u = 2;
%     for N = 1:Q
%         Monoms = 2*ones(N,N+1);
%         Monoms(:,1:N) = Monoms(:,1:N) - tril(ones(N));
%         Monoms = flip(Monoms,1);
% 
%         for l = 1:N+1
%             poly = 0;
%             for j = 1:size(temp,1)
%                 mono = 1;
%                 for h = 1:N
%                     mono = mono * V(Monoms(h,l),temp(j,h));
%                 end
%                 poly = poly + mono;
%             end
% 
%             tests(:,u) = tests(:,u) + mono * C(:,i);
% 
%             u = u + 1;
%         end
%     end
% end