function problem3 = PS0_Q1()
load('PS0_A.mat','A');
A = sort(A,'descend');
plot(A);

hist(A,10);

Z = A(51:100,1:50);
imagesc(Z);

mean_value = mean(A);
W = A - mean_value; 
imagesc(W);

Y = zeros(size(A,1),size(A,2),3)
t = mean_value;
ind1 = find(A-t>0);
Y(ind1) = 255;
ind2 = find(A-t<=0);
Y(ind2) = (0);
imshow(Y)
end






