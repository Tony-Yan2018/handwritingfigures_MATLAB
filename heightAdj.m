% adjusts the height of a number image
function imAdjusted=heightAdj(im)
for i=1+1:size(im,1)-1
    if sum(im(i,:))==0 && sum(im(i+1,:))>0
        im = im(i+1:end,:);
        break;
    end
end
for i=size(im,1):-1:2
    if sum(im(i,:))==0 && sum(im(i-1,:))>0
        im = im(1:i-1,:);
        break;
    end
end
imAdjusted = im;