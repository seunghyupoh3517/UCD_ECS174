function H = computeH(t1, t2)
% t1, t2 correspoding points of 2xN matrices - computes 3x3 homography matrix x 
% n >= 4 pairs from getCorrespondences
t1 = t1';
t2 = t2';

% create a new matrix
n = size(t1, 1);
A = zeros(2*n, 9);

% fill it up
for i = 1:n
    temp =[t1(i,1) t1(i,2) 1 0 0 0 (-t1(i,1)*t2(i,1)) (-t1(i,2)*t2(i,1)) -t2(i,1);
          0 0 0 t1(i,1) t1(i,2) 1 (-t1(i,1)*t2(i,2)) (-t1(i,2)*t2(i,2)) -t2(i,2)];
    A = [A;temp];
end
[V,D] = eig(A'*A);
[~,ind] = min(diag(D));
Hshape = V(:,ind);
H = reshape(Hshape,3,3)';

% Verify - imshow, hold on, plot
% It works - to include in the fuction, need to change the given parameter
end
