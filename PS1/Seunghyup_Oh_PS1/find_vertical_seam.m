function verticalSeam = find_vertical_seam(cumulativeEnergyMap)
%to cocpute the optical vertical seam.
%c(i,j) = e(i,j) + min(c(i-1,j-1), c(i-1,j), c(i-1,j+1))
len1 = size(cumulativeEnergyMap,1);
len2 = size(cumulativeEnergyMap,2);
verticalSeam = zeros(1,len1);

seam = cumulativeEnergyMap(len1,:);
index = find(seam == min(seam));
[val,index] = min(cumulativeEnergyMap(len1,:));
verticalSeam(len1)=index;
map = cumulativeEnergyMap;

    for i = (len1-1):-1:1 
        if index <= 1
            A = [map(i,index)  map(i,index+1)];  
        elseif index == len2    
            A = [map(i,index-1)  map(i,index)];
        else       
            A=[map(i,index-1) map(i,index) map(i,index+1)];
        end
        
        [val,newindex] = min(A);
        final = index + newindex - 2;
        verticalSeam(i) = final;
        index = final;
    end   
verticalSeam = verticalSeam';
end