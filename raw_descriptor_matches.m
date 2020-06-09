function raw_descriptor_matches
% SelectRegion.m , twoFrameData.mat 
addpath('provided_code');
fname = 'twoFrameData.mat';
load(fname, 'im1', 'im2', 'positions1', 'orients1', 'scales1', 'descriptors1',...
    'positions2', 'orients2', 'scales2', 'descriptors2');

% imshow(im1) in selectRegion.m already;
% Display the selected region of interest (polygon)
[oninds] = selectRegion(im1, positions1);
ind2 = [];
% less threshold around 0.4 - 0.5 could yeild less errors but wanted the
% result to match the given instruction; thus, set it 0.8
threshold = 0.8;
rowsize = size(oninds,1);

% Match descriptors to descriptors of second image 
for i = 1:rowsize
    % using Euclidean distance in SIFT space
    euclidean = dist2(descriptors1(oninds(i),:), descriptors2);
    % minimum ecudlidean
    [row,column] = min(euclidean);
    index = column(1); 
    
    minimumUnmatch = min(euclidean(euclidean~=row(1)));
    ratio = row/minimumUnmatch;
    % filter response for the threshold
    if (ratio < threshold)  
        % concatenate ind2 & index with 1 dimension
        ind2 = cat(1,ind2,index);
    end
end

% Display the second image with descriptor matchingrde
figure;
imshow(im2); %in displaySIFTPatches();
displaySIFTPatches(positions2(ind2,:), scales2(ind2), orients2(ind2), im2);  
end