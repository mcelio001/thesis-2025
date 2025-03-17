function [orders,coeff] = functionOrder(k,Q)
    if Q <= 4
        [orders,coeff] = functionOrder_1(k,Q);
    else
        [orders,coeff] = functionOrder_2(k,Q);
    end 
end