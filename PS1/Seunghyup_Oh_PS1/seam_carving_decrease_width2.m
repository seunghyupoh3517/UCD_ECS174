function seam_carving_decrease_width2    
    i2 = imread('inputReduceWidthMall.jpg');
    imshow(i2);
    title('769X775');
    
    ienergy2 = i2;
    energy2 = energy_img(i2);
    for i = 1:1:100
        [ienergy2, energy2] = decrease_width(ienergy2, energy2);
    end
    imwrite(ienergy2, 'outputReduceWidthMall.png');
    imshow(ienergy2);
    title('769X675');
end
