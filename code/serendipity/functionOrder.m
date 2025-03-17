function [orders,coeff] = functionOrder(k,Q)
    if Q <= 4
        [orders,coeff] = functionOrder_1(k,Q);
    else
        [orders,coeff] = functionOrder_2(k,Q);
    end
    if k == Q
        [~,ind] = ismember(1:k, orders.','rows');
        temp = orders(:,k*Q+1);
        orders(:,k*Q+1) = orders(:,ind);
        orders(:,ind) = temp;
        temp = coeff(k*Q+1);
        coeff(k*Q+1) = coeff(ind);
        coeff(ind) = temp;
    end
end