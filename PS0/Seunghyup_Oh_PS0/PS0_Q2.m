function short_programming = PS0_Q2()
load('PS0_B','I');
imagesc(I);
title('Input image');
hold off;

figure;
subplot(2, 3, 1);
Ia = rgb2gray(I);
imshow(Ia);
title('Grayscale');

subplot(2, 3, 2);
Ib = 255 - Ia;
imshow(Ib);
title('Negative');

subplot(2, 3, 3);
Ic = flipdim(I,2); 
imshow(Ic);
title('Mirror');

subplot(2, 3, 4);
Id(:,:,1)=I(:,:,3);
Id(:,:,2)=I(:,:,2);
Id(:,:,3)=I(:,:,1);
imshow(Id);
title('Swap Red&Blue');

subplot(2, 3, 5);
Ie=(double(I)+double(Ic))/2;
uint8(Ie);
imshow(Ie);
title('Average input with mirror');

subplot(2, 3, 6);
If = Ia + uint8(rand(size(Ia))*255);
%ind1 = find(If > 255);  
%If(ind1) = 255;
%ind2 = find(If < 0);  
%If(ind2) = 0;
%uint8(If); Unnecesarry steps to threshold as it won't go over 255 or under
%0 as I type casted the random values which I am adding to If
imshow(If);
title('Add/Thresholded image')
end