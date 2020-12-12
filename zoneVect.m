% returns a characteristic vector m*n of a segmented figure image
function y=zoneVect(im,m,n)
[a,b] =size(im);
vectEach = zeros(m,n);
% get cut coordinates
vertiCoord = round(linspace(1,a,m+1));
horizCoord = round(linspace(1,b,n+1));
for p=1:m
    for q=1:n
    % count pixels of a zone with normalization
    vectEach(p,q) = sum(im(vertiCoord(p):vertiCoord(p+1),horizCoord(q):horizCoord(q+1)) ,'all')/((vertiCoord(p+1)-vertiCoord(p))*(horizCoord(q+1)-horizCoord(q)));
    end
end
y=vectEach;