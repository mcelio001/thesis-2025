function A = serendipityMatrix(V,Q)
    % Construct the serendipity matrix

    k = size(V,2);
    
    % Function ordering and number of times each function is counted
    [orders,coeff] = functionOrder(k,Q);
    % Maximum number of times any function can be counted
    c_max = factorial(Q);
    % Number of functions
    n_fun = size(orders,2);
    
    % Matrix of constraints (both in B and in the known terms)
    MAT = zeros((Q+1)*(Q+2)/2, n_fun);
    
    % Constant constraints
    MAT(1,:) = c_max * ones(1, n_fun);
    
    % Monomial constraints
    u = 2; % Current matrix row
    perms_index = perms(Q:-1:1); % All possible index permutations
    for N = 1:Q
        % All possible monomials of a given degree
        % Represented as a matrix column (1 = x; 2 = y)
        Monoms = 2*ones(N,N+1);
        Monoms(:,1:N) = Monoms(:,1:N) - tril(ones(N));
        Monoms = flip(Monoms,1);

        % Sum over all possible permutations for a given monomial
        for i = 1:N+1
            % Final evaluated result (polynomial-like)
            poly = zeros(1,n_fun);
            for j = 1:c_max
                % Evaluation for current index permutation (monomial-like)
                mono = ones(1,n_fun);
                for h = 1:N
                    % Generate evaluation
                    mono = mono .* V(Monoms(h,i),orders(perms_index(j,h),:));
                end
                poly = poly + mono;
            end
            % Insert final result into matrix of constraints
            MAT(u,:) = poly;
            u = u + 1;
        end
    end

    % Adjust constraints based on the number of times each function is counted
    coeffs = repmat(coeff, [(Q+1)*(Q+2)/2 1]);
    MAT = MAT .* coeffs / c_max;
    
    % Number of serendipity functions
    % (To account for underconstrained cases when functions are only on the boundary)
    n_ser = max(k*Q,(Q+1)*(Q+2)/2);
    %n_ser = max(n_ser,17);
    if k == Q && k ~= 3
        n_ser = n_ser + 1;
    end

    % Matrix B
    B = MAT(:,1:n_ser);
    % Matrix of known terms
    QS = MAT(:,n_ser+1:end);
    % Serendipity matrix (pinv(B) times each column of QS gives a column of A')
    A = [eye(n_ser) pinv(B)*QS];
    %A = B;
end