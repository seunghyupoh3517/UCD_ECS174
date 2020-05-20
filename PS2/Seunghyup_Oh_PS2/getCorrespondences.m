function [corres1, corres2] = getCorrespondences(image1, image2, N)
% Write code to get manually identified correspoding points from two views
% ginput = collect mouse click position, [X, Y, Button] = ginput(N)
I1 = imread(image1);
I2 = imread(image2);
% Throw error when there are fewer than 4 pairs of corresponding points
if N < 4
    msg = 'Error N < 4: there must not be fewer than 4 pairs of corresponding points';
    error(msg)
end
% When you compute the homography matrix using n (>=4) corresponding points that you initially chose, 
% you can check the homography matrix by applying it on the chosen points in the first image, and 
% see where they get mapped to (you know what is the ideal mapping since you yourself chose the target 
% points in the second image.)
imagesc(I1);
[x1, y1] = ginput(N);
corres1 = [x1, y1]';

imagesc(I2);
[x2,y2] = ginput(N);
corres2 = [x2, y2]';
end