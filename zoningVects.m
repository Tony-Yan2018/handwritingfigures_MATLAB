% gives the characteristic vector of all the numbers
function y=zoningVects(im, m, n) % please pass a pretreated image
imRows = getRows(im);
imCols = getColumns(im,imRows);
vectAll = zeros(10,20,m, n);
for i=1:2:length(imRows)
    for j=1:2:size(imCols,2)
        y_ul = imRows(i);% ul for upper left
        y_ll = imRows(i+1);% ll for lower left
        x_ul = imCols((i+1)/2,j);
        x_ur = imCols((i+1)/2,j+1);% ur for upper right
        subImDim_1 = y_ll-y_ul;
        subImDim_2 = x_ur-x_ul;
        % get every number
        subIm = imcrop(im, [x_ul,y_ul,subImDim_2, subImDim_1]);
        % adjust height and get new size
        subIm = heightAdj(subIm);
        vectAll((i+1)/2,(j+1)/2, :, :) = zoneVect(subIm,m,n);
    end
end
y=vectAll;
        
        
