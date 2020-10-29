% calculates the distance from test sample x to all the known samples
function y=zVectDistance(x, vectAll)
dist = zeros(10,20);
for i=1:10
    for j=1:20
        current = squeeze(vectAll(i,j,:,:));
        sq = (x-current).^2;
        dist(i,j) = sqrt(sum(sq ,'all'));
    end
end
y=dist;