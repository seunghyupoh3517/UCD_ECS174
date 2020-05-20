function [warpIm, mergeIm] = warpImage(inputIm, refIm, H)
%inputIm = imread(inputIm);
%refIm = imread(refIm);
inputIm = double(inputIm);
refIm = double(refIm);

[hI,wI,~] = size(inputIm);
[hR,wR,dR] = size(refIm);
% returns 2 images as outputs
% warpIm - inputIm warped according to H to be in refIm
% mergeIm - single mosaic image with a larger field of view cotaining both
% MXNX3 = both input & outputs
% inverse warp - points from the input into ref frame
% compute bounding box in new ref frame
% sample all points in bounding box from cc1, cc2.mat
% large enough to hold the views, overlay one to another
% corner conversion
warpCorner = zeros(2,4); 
% H -> 3x3 * 3x4 -> 3x4 -> 2x4  frame 2X4 keep it 1
%frame = H * temp
%for i = 1:size(frame)+1
%   frame(3,i) = 1;
%end
temp = [1,1,wI,wI;1,hI,1,hI;1,1,1,1];
frame = H * temp;       
frame = frame./frame(3,:);
% frame(end,:) = [];
% frame: 2x4
 
% bounding box
topLeft = max([frame(1,:),wR]);
bottomLeft = min([frame(1,:),0]);
height = fix(topLeft) - fix(bottomLeft);

topRight = max([frame(2,:),hR]);
bottomRight = min([frame(2,:),0]);
width = fix(topRight) - fix(bottomRight);
% create empty image to print out with the size
warpIm = zeros(hR,wR,dR);
mergeIm = zeros(width,height,dR);
% --------------------------------
% [x, y] = meshgrid();
for i=1:width
    for j=1:height
        
        tilt = H \ [j+fix(bottomLeft);i + fix(bottomRight); 1];
        % last index -> 1
        x = tilt(2)/tilt(3); y = tilt(1)/tilt(3);
        % nested for loop - 
        if (x<=hI) && (y<=wI) && (x>=1) && (y>=1) 
            mergeIm(i,j,:) = round((fix(x+1)-x)*(fix(y+1)-y)*inputIm(fix(x),fix(y),:)...
                             + (x-fix(x))*(fix(y+1)-y)*inputIm(fix(x+1),fix(y),:)...
                             + (x-fix(x))*(y-fix(y))*inputIm(fix(x+1),fix(y+1),:)...
                             + (fix(x+1)-x)*(y-fix(y))*inputIm(fix(x),fix(y+1),:));
        end
        
        % check the other half
        if (j> -fix(bottomLeft)) && (i> -fix(bottomRight)) && (j< wR + 1 -fix(bottomLeft)) && (i<hR-fix(bottomRight))
            warpIm(i+fix(bottomRight),j+fix(bottomLeft),:) = mergeIm(i,j,:);
            mergeIm(i,j,:) = refIm(i+fix(bottomRight),j+fix(bottomLeft),:);
        end  
        
    end
end
figure;
imshow(uint8(warpIm));
figure;
imshow(uint8(mergeIm));
end