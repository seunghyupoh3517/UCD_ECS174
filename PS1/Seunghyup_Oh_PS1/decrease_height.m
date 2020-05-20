function [reducedColorImg,reducedEnergyImg] = decrease_height(im,energyImg)
x = size(im,1);
y = size(im,2);
reducedColorImg = uint8(zeros(x-1, y ,3));
reducedEnergyImg = zeros(x-1, y);
map = cumulative_min_energy_map(energyImg, 'HORIZONTAL');
hSeam = find_horizontal_seam(map);

r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

    for i = 1:y
        
        r1 = r(:,i);
        r1(hSeam(i)) = [];
        
        g1 = g(:,i);
        g1(hSeam(i)) = [];
        
        b1 = b(:,i);
        b1(hSeam(i)) = [];
    
        h = cat(3, r1, g1, b1);
        reducedColorImg(:,i,:) = h;
        h = energyImg(:,i);
        h(hSeam(i)) = [];
        reducedEnergyImg(:,i) = h;
    
    end
end
    
