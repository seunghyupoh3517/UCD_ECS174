function [reducedColorImg,reducedEnergyImg] = decrease_width(im,energyImg)
x = size(im,1);
y = size(im,2);
reducedColorImg = uint8(zeros(x, y-1,3));
reducedEnergyImg = zeros(x, y-1);
map = cumulative_min_energy_map(energyImg, 'VERTICAL');
vSeam = find_vertical_seam(map);

r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

    for i = 1:x
        r1 = r(i,:);
        r1(vSeam(i)) = [];
        
        g1 = g(i,:);
        g1(vSeam(i)) = [];
        
        b1 = b(i,:);
        b1(vSeam(i)) = [];
    
        h = cat(3, r1, g1, b1);
        reducedColorImg(i,:,:) = h;
        h = energyImg(i,:);
        h(vSeam(i)) = [];
        reducedEnergyImg(i,:) = h;
    
    end
end
    
