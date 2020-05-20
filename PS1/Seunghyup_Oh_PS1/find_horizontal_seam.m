function horizontalSeam = find_horizontal_seam(cumulativeEnergyMap)
%to cocpute the optical horizontal seam.
%c(i,j) = e(i,j) + min(c(i-1,j-1), c(i-1,j), c(i-1,j+1))
len1 = size(cumulativeEnergyMap,1);
len2 = size(cumulativeEnergyMap,2);
horizontalSeam = zeros(1,len2);

%seam = cumulativeEnergyMap(len2,:);
%index = find(seam == min(seam));
[val,index] = min(cumulativeEnergyMap(:,len2));
horizontalSeam(len2)=index;
map = cumulativeEnergyMap;

    for i = (len2-1):-1:1 
        if index <= 1
            A = [map(index,i)  map(index+1,i)];  
        elseif index == len1    
            A = [map(index-1,i)  map(index,i)];
        else       
            A=[map(index-1,i) map(index,i) map(index+1,i)];
        end
        
        [val,newindex] = min(A);
        final = index + newindex - 2;
        horizontalSeam(i) = final;
        index = final;
    end   
end