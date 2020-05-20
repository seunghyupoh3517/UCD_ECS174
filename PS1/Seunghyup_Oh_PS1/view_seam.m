function view = view_seam(im,seam,seamDirection)
x = size(im,1);
y = size(im,2);

    if strcmp(seamDirection, 'HORIZONTAL')
        for i = 1:y
            im(seam(i),i,:) = [255,0,0];
        end
    else
        for i = 1:x
            im(i,seam(i),:) = [255,0,0];
        end
    end
view = im;
end

         