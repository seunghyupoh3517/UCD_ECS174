function visualize_vocabulary
% getPatchFromSIFTParameters.m , kMeans.mat
% basic set up to load from other directories
addpath('provided_code');
framesdir = 'frames';
siftdir = 'sift';
fnames = dir([siftdir '/*.mat']);

% 25 patches per word displayed - 50 pathces needed
% number of sample frmaes to be randomly sampled enough for 25 patches
N = 200;
% set up the vocabulary class to store variable data
vocabDes = []; 
vocabPoss = [];
vocabScale = [];
vocabOrients = [];
vocabFrame = [];
vocabNum = [];
vocabCorn = [];
vocabDep = [];
% in the sift directory, go over the data put descriptors 
sizeSift = length(fnames);
for i=1:sizeSift
    % every 20 frames
    if (mod(i,20)~=0)
        continue;
    end
    
    % calling the words
    fname = [siftdir '/' fnames(i).name];
    % loading all the variables from the sift image 
    load(fname, 'descriptors', 'orients', 'scales', 'positions', 'numfeats',...
        'corners', 'imname', 'deepFC7');
    if size(descriptors,1) == 0
        continue;
    end
    % 500 sample descriptors into SIFT space of vocab class  
    descrip1 = size(descriptors,1);
    % make it random smapled descriptors
    randinds = randperm(descrip1);
    % vocabulary class
    vocabDes = cat(1,vocabDes, descriptors(randinds(1:min([N,descrip1])),:));
    vocabPoss = cat(1,vocabPoss, positions(randinds(1:min([N,descrip1])),:));
    vocabScale = cat(1,vocabScale, scales(randinds(1:min([N,descrip1]))));
    vocabOrients = cat(1,vocabOrients, orients(randinds(1:min([N,descrip1]))));
    % putting frames
    for j = 1:N
        vocabFrame = cat(1,vocabFrame,imname);
    end
end
% function [membership,means,rms] = kmeansML(k,data,varargin)
% k = 1500 
transVocabDes = vocabDes';
[membership,means,rms] = kmeansML(1500,transVocabDes);
vocabMember = membership;
kMeans = means;
sizeMeans = size(kMeans,2);
count = zeros(sizeMeans,1);

for i=1:length(vocabMember)
    def = vocabMember(i);
    count(def) = count(def)+1;
end

[max1,col1] = max(count);
max2 = 0;
col2 = 0;

if (length(col1) >= 2)
    col2 = col1(2);
    max2 = max1(2);
end

if (length(col1) < 2)
    [max2,col2] = max(count(count~=max1));
end

% max1 ==  max2 < 25 make sure

% finding the matching index to vocaMembers
patches1 = find(vocabMember==col1);
patches2 = find(vocabMember==col2);


% transpose
word1 = kMeans(:,col1)';
word2 = kMeans(:,col2)';

% saving into the matrix to display
display1 = [];
for i = 1:length(patches1)
    distance = dist2(word1, vocabDes(patches1(i),:));
    d = distance(1);
    v = [d patches1(i)];
    display1 = cat(1,display1, v);
end

% saving into the matrix to display
display2 = [];
for i = 1:length(patches2)
    distance = dist2(word2, vocabDes(patches2(i),:));
    d = distance(1);
    v = [d patches2(i)];
    display2 = cat(1,display2, v);
end

display1 = sort(display1);
display2 = sort(display2);

% display two words with 25 patches per each
figure;
for i = 1:25
    ind = display1(i,2);
    imname = [framesdir '/' vocabFrame(ind,:)]; 
    im = imread(imname);
    grayim = rgb2gray(im);
    %provided_code - getPatchFromSIFTParameters()
    patch = getPatchFromSIFTParameters(vocabPoss(ind,:), vocabScale(ind), vocabOrients(ind),grayim);
    subplot(5,5,i);
    imshow(patch);
end

figure;
for i = 1:25
    ind = display2(i,2);
    imname = [framesdir '/' vocabFrame(ind,:)]; 
    im = imread(imname);
    grayim = rgb2gray(im);
    %provided_code - getPatchFromSIFTParameters()
    patch = getPatchFromSIFTParameters(vocabPoss(ind,:), vocabScale(ind), vocabOrients(ind),grayim);
    subplot(5,5,i);
    imshow(patch);
end

% submit visual words in a file called kMeans.mat
% a matrix of size k(=1500) x 128 kMeans -> transpose it again
kMeans = kMeans';
% save it to kMeans
save('kMeans.mat', 'kMeans');
end