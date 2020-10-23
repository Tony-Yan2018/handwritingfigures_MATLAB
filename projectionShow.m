[m,n]=size(im);

for y=1:n
    SV(y) = sum(im(:,y));
end
for x=1:m
    SH(x) = sum(im(x,:));
end
x=1:m;
y=1:n;
subplot(2,1,1), plot(y,SV(y)),title("Vertical Projection")
subplot(2,1,2), plot(x,SH(x)),title("Horizontal Projection")