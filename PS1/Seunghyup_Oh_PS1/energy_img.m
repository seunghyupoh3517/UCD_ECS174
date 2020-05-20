function energyImg = energy_img(im)
%to compute the energy at each pixel using the magnitude of the x and y gradients (equation 1 in the paper; sqrt(dx^2+dy^2)).
grayscale = rgb2gray(im);
Dy = fspecial('sobel');
%Dy = fspecial('prewitt');
Dx = -Dy';
dx = imfilter(double(grayscale), Dx);
dy = imfilter(double(grayscale), Dy);
energyImg = sqrt(dx.^2 + dy.^2);


%imagesc(energyImg);
%colormap gray;

end