function seam_carving_decrease_height
    i = imread('inputSeamCarvingPrague.jpg');
    imshow(i);
    title('480X640');
    
    ienergy = i;
    energy = energy_img(i);
    for i = 1:1:50
        [ienergy, energy] = decrease_height(ienergy, energy);
    end
    imwrite(ienergy, 'outputReduceHeightPrague.png');
    imshow(ienergy);
    title('430X640');
end
