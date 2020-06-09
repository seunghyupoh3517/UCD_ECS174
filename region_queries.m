function region_queries
% basic set up to load from other directories
addpath('./provided_code/');
framesdir = './frames/';
siftdir = './sift/';
load('kMeans.mat');
load('histograms.mat');
fnames = dir([siftdir '/*.mat']);
% 3 = 1 successful 1 successful admist different object 1 failure
framenames = ['/friends_0000000090.jpeg';  % shirt - success
               '/friends_0000003042.jpeg';  % apple - failure
               '/friends_0000001800.jpeg'];  % face - failure success
               

%for each query region
queryRanking = [];
% three query images
framefile = strcat(framenames(1,:), '.mat');
im = dir([siftdir framefile]);
fname = [siftdir '/' im.name];
load(fname, 'descriptors', 'positions');
imname = [framesdir framenames(1,:)];
im1 = imread(imname);
[inds1, bounds1] = selectedRegion(imname,positions);
des1 = descriptors(inds1,:);
[h,~] = makeHistogram(des1, kMeans);
queryRanking = cat(1,queryRanking,h');    


framefile = strcat(framenames(2,:), '.mat');
im = dir([siftdir framefile]);
fname = [siftdir '/' im.name];
load(fname, 'descriptors', 'positions');
imname = [framesdir framenames(2,:)];
im2 = imread(imname);
[inds2, bounds2] = selectedRegion(imname,positions);
des2 = descriptors(inds2,:);
[h,~] = makeHistogram(des2, kMeans);
queryRanking = cat(1,queryRanking,h'); 


framefile = strcat(framenames(3,:), '.mat');
im = dir([siftdir framefile]);
fname = [siftdir '/' im.name];
load(fname, 'descriptors', 'positions');
imname = [framesdir framenames(3,:)];
im3 = imread(imname);
[inds3, bounds3] = selectedRegion(imname,positions);
des3 = descriptors(inds3,:);
[h,~] = makeHistogram(des3, kMeans);
queryRanking = cat(1,queryRanking,h');    
% sort to get top 5
ranking1 = [];
ranking2 = [];
ranking3 = [];
names1 = [];
names2 = [];
names3 = [];
% otherwise, it freezes from the selecting region
close all;

for i=1:length(fnames) 
    %load all images  

    % load that file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors');
    if size(descriptors,1) == 0
        continue;
    end
    % three images from chosen continuing to next images
    if strcmp(framenames(1,:), imname)
        continue;
    end
    if strcmp(framenames(2,:), imname)
        continue;
    end
    if strcmp(framenames(3,:), imname)
        continue;
    end
    imname = [framesdir imname]; 

    %  for every loading image get histograms
    h = histograms(i,:);
    % check the scores to make  a ranking
    number1 = rankingCheck(queryRanking(1,:), h);
    number2 = rankingCheck(queryRanking(2,:), h);
    number3 = rankingCheck(queryRanking(3,:), h);
    % > 0.5 fail 
    if (number1 > 0) %  not same ass the full_fram  queires.m
        ranking1 = cat(1,ranking1,number1);
        names1 = cat(1, names1, imname);
    end
    if (number2 > 0)
        ranking2 = cat(1,ranking2,number2);
        names2 = cat(1, names2, imname);
    end
    if (number3 > 0)
        ranking3 = cat(1,ranking3,number3);
        names3 = cat(1, names3, imname);
    end        

end
disp(size(ranking2));

% sorting the rankings
rank1 = sortRanking(ranking1, names1);
rank2 = sortRanking(ranking2, names2);
rank3 = sortRanking(ranking3, names3);
% rank4 = sortRanking(ranking4, names5);
% rank5 = sortRanking(ranking4, names5);

%display top 5 results for each query image
figure;
subplot(2,3,1); % subplotting six frames into one
% adding the full path to it
imname = [framesdir framenames(1,:)];
im = imread(imname);
imshow(im);
hold on;
h = fill(bounds1(:,1),bounds1(:,2), 'b');
set(h, 'FaceColor','none');
set(h, 'EdgeColor','y');
set(h, 'LineWidth',2);
title('Query Frame');
for i = 1:size(rank1,1)
    subplot(2,3,i+1);
    reading1 = imread(rank1(i,:));
    imshow(reading1);
    title1 = ['Similar Rank ' int2str(i)];
    title(title1);
end

%display top 5 results for each query image
figure;
subplot(2,3,1); % subplotting six frames into one
% adding the full path to it
imname = [framesdir framenames(2,:)]; 
im = imread(imname);
imshow(im);
hold on;
h = fill(bounds2(:,1),bounds2(:,2), 'b');
set(h, 'FaceColor','none');
set(h, 'EdgeColor','y');
set(h, 'LineWidth',2);
title('Query Frame');
for i = 1:size(rank2,1)
    subplot(2,3,i+1);
    reading2 = imread(rank2(i,:));
    imshow(reading2);
    title2 = ['Similar Rank' int2str(i)];
    title(title2);
end

%display top 5 results for each query image
figure;
subplot(2,3,1); % subplotting six frames into one
% adding the full path to it
imname = [framesdir framenames(3,:)];
im = imread(imname);
imshow(im);
hold on;
h = fill(bounds3(:,1),bounds3(:,2), 'b');
set(h, 'FaceColor','none');
set(h, 'EdgeColor','y');
set(h, 'LineWidth',2);
title('Query Frame');
for i = 1:size(rank3,1)
    subplot(2,3,i+1);
    reading3 = imread(rank3(i,:));
    imshow(reading3);
    title3 = ['Similar Rank' int2str(i)];
    title(title3);
end
end