function cumulativeEnergyMap = cumulative_min_energy_map(energyImg, seamDirection)
%to compute minimum cumulative energy.    
map = zeros(size(energyImg));
    
    if strcmp(seamDirection, 'VERTICAL')
        map(1,:) = energyImg(1,:);
        for i = 2:size(energyImg,1)
            for j = 1:size(energyImg,2)
                x = map(i-1,j);
                if (j-1)>0
                    x = [x, map(i-1, j-1)];
                end

                if (j+1)<size(energyImg,2)
                    x = [x, map(i-1, j+1)];
                end
                map(i,j) = energyImg(i,j) + min(x);
            end
        end
        

    elseif strcmp(seamDirection, 'HORIZONTAL')
        map(:,1) = energyImg(:,1);
        for i = 2:size(energyImg,2)
            for j = 1:size(energyImg,1)
                x = map(j,i-1);
                if (j-1)>0
                    x = [x map(j-1, i-1)];
                end
                if (j+1)<size(energyImg,1)
                    x = [x map(j+1, i-1)];
                end
                map(j,i) = energyImg(j,i) + min(x);
            end
        end
    end
cumulativeEnergyMap = map;
end
        
        
        