function [occurence, ind] = makeHistogram(image,vocab)
% convert all the frames into histograms of bag of words
% based on kMeans.mat data using dist2
% addpath('provided_code');
% framesdir = 'frames';
% siftdir = 'sift';
% fnames = dir([siftdir '/*.mat']);
distance = dist2(image,vocab); 
freq = zeros(size(image,1),1); 
[~, freq] = min(distance,[],2);
k = 1500;
% histcounts
[occurence, ind] = histc(freq,1:k);
if (size(occurence,1)==1)
    x = occurence';
    occurence = x;
end

end