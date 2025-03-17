function coeff = orderCoeff(orders)
    % Calculates number of instances of each function index combination

    N = size(orders,2);
    coeff = zeros(1,N);
    Q = size(orders,1);
    c_max = factorial(Q);

    for i = 1:N
        % Current function index set
        v = orders(:,i);

        % Find number and distribution of unique digits
        cs = zeros(Q,1); % Frequency of each digit
        cs(1) = 1;
        curr_num = v(1); % Current digit (to check against the others)
        curr_ind = 1; % Counter for the current digit
        % Comb through the index set to count the frequency of digits
        for j = 2:Q
            % If a new digit is found, stop counting the old one and start counting that
            if v(j) ~= curr_num
                curr_ind = curr_ind + 1;
                curr_num = v(j);
            end
            % Count the current digit
            cs(curr_ind) = cs(curr_ind) + 1;
        end

        % Find number of combinations
        % The number is a polynomial coefficient based on the frequency of digits
        c = c_max;
        for j = 1:curr_ind
            c = c / factorial(cs(j));
        end
        coeff(i) = c;
    end
end