function seam_carving_decrease_width
    i = imread('inputSeamCarvingPrague.jpg');
    
    imshow(i);
    title('480X640');
    
    ienergy = i;
    energy = energy_img(i);
    for i = 1:1:100
        [ienergy, energy] = decrease_width(ienergy, energy);
    end
    imwrite(ienergy, 'outputReduceWidthPrague.png');
    imshow(ienergy);
    title('480X540');
    
    %i_e = energy_img(i);
    %energyMap_h = cumulative_min_energy_map(i_e, 'HORIZONTAL');
    %energyMap_v = cumulative_min_energy_map(i_e, 'VERTICAL');
    %subplot(2, 3, 1);
    %imagesc(energyMap_h);
    %colormap gray;
    %subplot(2, 3, 2);
    %imagesc(energyMap_v);
    %colormap gray;
    
    %seamHmap = cumulative_min_energy_map(energy, 'HORIZONTAL');
    %hSeam = find_horizontal_seam(seamHmap);
    %displayhSeam1 = view_seam(i,hSeam,'HORIZONTAL');
    %subplot(2,3,1);
    %imagesc(displayhSeam1)
    %title('PREWITT FILTER - H');
   
    %seamVmap = cumulative_min_energy_map(energy, 'VERTICAL');
    %vSeam = find_vertical_seam(seamVmap);
    %displayvSeam2 = view_seam(i,vSeam,'VERTICAL');
    %subplot(2,3,2);
    %imagesc(displayvSeam2)
    %title('PREWITT FILTER - V');
end
