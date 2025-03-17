Q = 3;
V1 = [[0;0] [1;0] [1;1]];
V2 = [[0;0] [1;0] [1;1/2] [1;1]];
tol = 1e-10;

k1 = size(V1,2)*Q; k2 = size(V2,2)*Q;
A1 = serendipityMatrix(V1,Q);
A2 = serendipityMatrix(V2,Q);
A1 = A1(:,1:k1);
A2 = A2(:,1:k2);

A3 = A2;
for i = 1:k1
    [~,ind] = ismember(A1(:,i)', A3', 'rows');
    if ind ~= 0
        A3(:,ind) = [];
    end
end

T1 = pinv(A1)*A2;

T2 = A1\A2;

C1 = A2 - A1*T1;
C2 = A2 - A1*T2;

T1(abs(T1) < tol) = 0;
T1(abs(T1) > tol) = T1(abs(T1) > tol) + 1e-14;
T2(abs(T2) < tol) = 0;
T2(abs(T2) > tol) = T2(abs(T2) > tol) + 1e-14;
C1(abs(C1) < tol) = 0;
C1(abs(C1) > tol) = C1(abs(C1) > tol) + 1e-14;
C2(abs(C2) < tol) = 0;
C2(abs(C2) > tol) = C2(abs(C2) > tol) + 1e-14;

T1 = pinv(A1)*A3;
T1(abs(T1) < tol) = 0;
T1(abs(T1) > tol) = T1(abs(T1) > tol) + 1e-14;
T2 = A1 \ A3;
T2(abs(T2) < tol) = 0;
T2(abs(T2) > tol) = T2(abs(T2) > tol) + 1e-14;