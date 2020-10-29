% returns probability vector of all test samples
function y=probKNNAll(imT, m, n, k, zoneVectAll)
imTRows = getRows(imT);
imTCols = getColumns(imT,imTRows);
distArrT =zeros(10,20);  % distance array of a test sample
probArrKNN = zeros(10,10,10);% all probability KNN vectors of test set
for i=1:2:length(imTRows)
    for j=1:2:size(imTCols,2)
        % upper left
        x = imTCols((i+1)/2,j);
        y = imTRows(i);
        % crop dimensions
        dim_x = imTCols((i+1)/2,j+1)-x;
        dim_y = imTRows(i+1)-y;
        % crop numbers and adjust height
        subIm = imcrop(imT,[x,y,dim_x,dim_y]);
        subIm = heightAdj(subIm);
        % characteristic vector x of a sample
        vectX = zoneVect(subIm,m,n);
        % distance array of a sample
        distArrT = zVectDistance(vectX,zoneVectAll);
        % its KNN probability related to 10 classes
        probArrKNN((i+1)/2,(j+1)/2,:,:) = probKNN(distArrT,k);
    end
end
y=probArrKNN;
        
        
        