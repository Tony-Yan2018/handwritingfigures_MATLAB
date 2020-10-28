function arr = posteriorProbs(im, imTest, k) % please pass pretreated images
imRows = getRows(im);
imCols = getColumns(im, imRows);
imTestRows = getRows(imTest);
imTestCols = getColumns(imTest, imTestRows);
centers = classCenters(im,imRows, imCols,k); % center of 10 classes
p = zeros(1,10); % a probability vector of belonging of a number to each of the 10 classes
pArr = zeros(length(imTestRows)/2, size(imTestCols,2)/2, 10); % probability vectors of all numbers [10,10,10]
for i=1:2:length(imTestRows)
    for j=1:2:size(imTestCols,2)
        % upper left coordinate
        x = imTestCols((i+1)/2,j);
        y = imTestRows(i);
        % crop dimension
        xCrop = imTestCols((i+1)/2,j+1)-x;
        yCrop = imTestRows(i+1)-y;
        % get each number in test.tif
        subIm = imcrop(imTest,[x,y,xCrop,yCrop]);
        subIm = heightAdj(subIm);
        % get its characteristic vector
        vect = vectN(subIm,k);
        denominator = deno(vect,centers);
        for a = 1:10
            numerator = exp(-dist(vect,centers(a,:).'));
            p(a) = numerator/denominator;
        end
        pArr((i+1)/2, (j+1)/2,:)=p;
        p = zeros(1,10);
    end
end
arr = pArr;
save('probVectsEucClassifier.mat','pArr');
            
            
            
function y=deno(x,w)
sum=0;
for i=1:10
    sum = sum+exp(-dist(x,w(i,:).'));
end
y=sum;