function C = Serendipity_coord(x,y,V,Q)
    % Generate serendipity coordinates

    % Quadratic coordinates
    M = Qth_coord(x,y,V,Q);
    % Serendipity matrix
    A = serendipityMatrix(V,Q);
    % Serendipity coordinates
    C = M*A';
end

