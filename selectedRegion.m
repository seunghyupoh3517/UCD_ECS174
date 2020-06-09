function [oninds, region] = selectedRegion(im, position)
% h = impoly(hparent) begins interactive placement of a polygon on the
% object specifeid by hparent h= impoly(hparent, position) creates a
% draggable resizealbe polygon with vertices 
imshow(im);
% takes users input, position and display image with yellow sketch
% returns indices to indicate the position - which points in the region
h = impoly(gca, []); % current axis
api = iptgetapi(h); % interactive modular tool
nextpos = api.getPosition();
region = nextpos;
% sketch region of the interest
imshow(im);
hold on;
h = fill(region(:,1),region(:,2), 'b');
set(h, 'FaceColor','none');
set(h, 'EdgeColor','y');
set(h, 'LineWidth',2);
% indices to the SIFT space polygon
ptsin = inpolygon(position(:,1), position(:,2), nextpos(:,1), nextpos(:,2));
oninds = find(ptsin==1); 