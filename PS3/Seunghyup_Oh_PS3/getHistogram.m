function getHistogram   
% basic set up to load from other directories
addpath('provided_code');
siftdir = 'sift';
fnames = dir([siftdir '/*.mat']);
load('kMeans.mat', 'kMeans');
% calling it from the makeHistogram
histograms = [];
k = 1500; % given kx
sizeframes = length(fnames);

for i=1:sizeframes 
    framename = [siftdir '/' fnames(i).name];
    load(framename, 'imname', 'descriptors');
    
    if (size(descriptors,1) > 0)
        [histogram,~] = makeHistogram(descriptors, kMeans);
    else
        % create the histoggram with the matching size
        histogram = zeros(k,1);
    end
    % transpose
    histograms = cat(1,histograms,histogram');
    if (i == 1000)
        save('histograms.mat', 'histograms');
    end
end
save('histograms.mat', 'histograms');
end