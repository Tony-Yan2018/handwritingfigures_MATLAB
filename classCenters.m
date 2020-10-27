% [10,10] the class center is the mean vector of 20 images of one number
function arr=classCenters(imbw, rows, cols,k)% k is the sample number of one side
eachV = zeros(1,k*2);
centersArr = zeros(10,k*2);
for i=1:2:length(rows)
    for j=1:2:size(cols,2)
        % upper left coordinate
        x=cols((i+1)/2,j);
        y=rows(i);
        % crop dimensions
        xCrop = cols((i+1)/2,j+1)-x;
        yCrop = rows(i+1)-y;
        % crop and adjust
        subIm = imcrop(imbw, [x,y,xCrop,yCrop]);
        subIm = heightAdj(subIm);
        %imshow(subIm);
        eachV = eachV + vectN(subIm, k);
    end
    centersArr((i+1)/2,:) = eachV/20;% the mean vector of number N
    eachV = zeros(1,k*2);
end
arr=centersArr;
