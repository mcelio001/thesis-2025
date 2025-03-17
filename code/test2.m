t = 1/2;

Q = 2;
V1 = [[0;0] [0;1] [1;1]];
V2 = [[0;0] [0;1-2*t] [0;1-t] [0;1] [1;1]];
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

os = functionOrder(k1/Q,Q);
inds = zeros(1,k1);
for i = 1:k1
    if or(ismember(os(:,i),1), ismember(os(:,i),2))
        inds(i) = 1;
    end
end
A4 = A1(:,find(inds));
os = os(:,find(inds));

T1 = A4\A3;
T2 = pinv(A4)*A3;

C1 = A3 - A4*T1;
% C1 = C1(:,find(inds));
C2 = A3 - A4*T2;
% C2 = C2(:,find(inds));

T1(abs(T1) < tol) = 0;
T1(abs(T1) > tol) = T1(abs(T1) > tol) + 1e-14;
T2(abs(T2) < tol) = 0;
T2(abs(T2) > tol) = T2(abs(T2) > tol) + 1e-14;
C1(abs(C1) < tol) = 0;
C1(abs(C1) > tol) = C1(abs(C1) > tol) + 1e-14;
C2(abs(C2) < tol) = 0;
C2(abs(C2) > tol) = C2(abs(C2) > tol) + 1e-14;

% t^2, t(1-t), (1-t)^2; 2t, 1-t