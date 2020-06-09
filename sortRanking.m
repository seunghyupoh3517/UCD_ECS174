function ranks = sortRanking(list, names)
% sorthing the similarity  scores between  a query histogram and histograms
% associated with the rest of the images in the video
[~, index] = sort(list, 'descend');
% descending order
ranks = [];
ranking = 5;
% top 5
    for i = 1:ranking
        n = names(index(i),:);
        ranks = cat(1,ranks,n);
        % make it to concatenate
    end
end