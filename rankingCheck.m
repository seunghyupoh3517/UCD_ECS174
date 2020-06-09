function rankingCheck = ranking(query, compare)
% norm function for the matrix
% scalar that gives some measure of the magnitude of the elements of the
% matrix -> normalized scalr product between their bag of words histograms
r1 = (query * compare');
r2 = norm(query, 'fro');
r3 = norm(compare, 'fro');
rankingCheck =  r1 / (r2 * r3);
% 'fro' to calculate the Frobenius nors of a sparse matrix
end