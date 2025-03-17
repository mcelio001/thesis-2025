function [orders,coeff] = functionOrder_2(k,Q)
    % Generate function ordering generalizing the ordering in Hackermack's paper
    % The ordering is:
    % vertex functions; edge functions; other functions in lexicographic-like order

    % Upper bound for number of functions
    N = 0;
    nums = k:-1:1;
    for i = 1:Q
        N = N + nums(1);
        for j = 1:k
            nums(j) = sum(nums(j:k));
        end
    end

    orders = zeros(Q,k*Q);
    
    % Vertex and edge functions
    for i = 0:Q-1
        orders(1:Q-i,i*k+1:k*(i+1)) = repmat(1:k,Q-i,1);
        orders(Q-i+1:Q,i*k+1:k*(i+1)) = repmat(mod(1:k,k)+1,i,1);
    end
    % Functions on last edge with indices in ascending order
    % Used for ease of comparison later
    last_edge = zeros(Q,Q-1);
    for i = Q-1:-1:1
        last_edge(1:Q-i,i) = ones(Q-i,1);
        last_edge(Q-i+1:Q,i) = k*ones(i,1);
    end
    le_counter = 1;
    
    v = ones(Q,1);
    v(Q) = 2;
    M = zeros(Q,N);
    c = 1;
    while(v(1) ~= k)
        if v(Q) >= k
            i = Q - 1;
            while v(i) >= k
                i = i - 1;
            end
            v(i) = v(i) + 1;
            v(i:Q) = v(i) * ones(Q-i+1,1);
        else
            v(Q) = v(Q) + 1;
        end
        if v(Q) - v(1) > 1
            if v == last_edge(:,le_counter)
                le_counter = min(le_counter + 1, Q-1);
            else
                M(:,c) = v;
                c = c + 1;
            end
        end
    end
    
    orders = [orders M(:,1:c-1)];

    % Calculate number of instances of each index combination
    if nargout > 1
        coeff = orderCoeff(orders);
    end
end