function [orders,coeff] = functionOrder_1(k,Q)
    % Generate function ordering generalizing the ordering in Hackermack's paper
    % The ordering is:
    % vertex functions; edge functions; other functions in lexicographic-like order

    orders = zeros(Q,k*Q);
    
    % Vertex and edge functions
    for i = 0:Q-1
        orders(1:Q-i,i*k+1:k*(i+1)) = repmat(1:k,Q-i,1);
        orders(Q-i+1:Q,i*k+1:k*(i+1)) = repmat(mod(1:k,k)+1,i,1);
    end
    % Write indices of functions on the last edge in increasing order
    % This is done for comparison purposes in the lexicographic-like portion
    for i = 2*k:k:k*Q
        orders(:,i) = flip(orders(:,i),1);
    end
    
    % Find all possible Q-length combinations of k numbers
    C = cell(1,Q);
    [C{:}] = ndgrid(1:k);
    C = cellfun(@(a)a(:),C,'Uni',0);
    M = [C{:}];
    % Sort each combination indices in ascending order (lexicographic-like)
    % Also include previously found vertex and edge functions (for ordering purposes)
    M = [orders sort(M,2)'];
    
    % Reduce all index combinations to only include unique ones
    [orders,~,coeff] = unique(M','stable','rows');
    orders = orders';
    % Find number of instances of each combination
    coeff = accumarray(coeff,1)';
    % Subtract 1 from all the instances of the vertex and edge function
    % This is because these functions have been added on top of the ordinary calculation.
    % Therefore, they are counted one extra time by default.
    coeff(1:k*Q) = coeff(1:k*Q) - 1;

    % Change back the indices order of functions on last edge
    for i = 2*k:k:k*Q
        orders(:,i) = flip(orders(:,i),1);
    end
end