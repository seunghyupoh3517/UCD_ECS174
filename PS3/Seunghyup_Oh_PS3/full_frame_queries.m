function full_frame_queries
% basic set up to load from other directories
addpath('./provided_code/');
framesdir = './frames/';
siftdir = './sift/';
%addpath('provided_code');
%framesdir = 'frames';
%siftdir = 'sift';

fnames = dir([siftdir '/*.mat']);
% need to have histograms for every scene - makeHistogram(), getHistogram()

% ranking / names list for the sortFrame
ranking1 = [];
ranking2 = [];
ranking3 = [];
ranking4 = [];
ranking5 = [];
names1 = [];
names2 = [];
names3 = [];
names4 = [];
names5 = [];

%load kMeans from part 2
%load precalculated histogram
load('kMeans.mat');
load('histograms.mat');
% choose images
frameName = ['/friends_0000000060.jpeg';
             '/friends_0000000285.jpeg';
             '/friends_0000002729.jpeg'];

queryRanking = [];

% checking the files called
for i = 1:size(frameName,1)
    framefile = strcat(frameName(i,:), '.mat');
    im = dir([siftdir framefile]);
    fname = [siftdir '/' im.name];
    load(fname, 'imname', 'descriptors');
    imname = [framesdir frameName(i,:)];
    [h,~] = makeHistogram(descriptors, kMeans);
    queryRanking = cat(1,queryRanking,h');
end


for i=1:length(fnames) 
    %load all images from the frame directory so that we can compare from the dataset 
    % loading the file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors');
    if size(descriptors,1) == 0
        continue;
    end
    
    % three images from chosen
    if strcmp(frameName(1,:), imname)
        continue;
    end
    if strcmp(frameName(2,:), imname)
        continue;
    end
    if strcmp(frameName(3,:), imname)
        continue;
    end
    imname = [framesdir imname]; 
    % get histogram from histogram.mat
    h = histograms(i,:);
    %compare histogram to any of the thee query images
    number1 = rankingCheck(queryRanking(1,:), h);
    %if the score is above a certain threshold
    if (number1 > 0.5)
        ranking1 = cat(1,ranking1,number1);
        names1 = cat(1, names1, imname);
    end
    number2 = rankingCheck(queryRanking(2,:), h);
    if (number2 > 0.5)
        ranking2 = cat(1,ranking2,number2);
        names2 = cat(1, names2, imname);
    end
    number3 = rankingCheck(queryRanking(3,:), h);
    if (number3 > 0.5)
        ranking3 = cat(1,ranking3,number3);
        names3 = cat(1, names3, imname);
    end
end

% sort to get top 5
rank1 = sortRanking(ranking1, names1);
rank2 = sortRanking(ranking2, names2);
rank3 = sortRanking(ranking3, names3);
% rank4 = sortRanking(ranking4, names5);
% rank5 = sortRanking(ranking4, names5);

%display top 5 results for each query image
figure;
subplot(2,3,1); % subplotting six frames into one
% adding the full path to it
imname = [framesdir frameName(1,:)];
im = imread(imname);
imshow(im);
title('Query Frame');
for i = 1:size(rank1,1)
    n = i+1;
    subplot(2,3,n);
    disp(rank1(i,:));
    reading1 = imread(rank1(i,:));
    imshow(reading1);
    title1 = ['Similar Rank ' int2str(i)];
    title(title1);
end

%display top 5 results for each query image
figure;
subplot(2,3,1); % subplotting six frames into one
% adding the full path to it
imname = [framesdir frameName(2,:)]; 
im = imread(imname);
imshow(im);
title('Query Frame');
for i = 1:size(rank2,1)
    subplot(2,3,i+1);
    reading2 = imread(rank2(i,:));
    imshow(reading2);
    title2 = ['Similar Rank ' int2str(i)];
    title(title2);
end

%display top 5 results for each query image
figure;
subplot(2,3,1); % subplotting six frames into one
imname = [framesdir frameName(3,:)]; 
% adding the full path to it
im = imread(imname);
imshow(im);
title('Query Frame');
for i = 1:size(rank3,1)
    subplot(2,3,i+1);
    reading3 = imread(rank3(i,:));
    imshow(reading3);
    title3 = ['Similar Rank ' int2str(i)];
    title(title3);
end