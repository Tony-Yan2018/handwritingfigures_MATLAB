function drawRects(im,rows,cols)
figure('Name', 'Rectangles drawn around characters');
imshow(im);
for i=1:2:length(rows)
    for j=1:2:size(cols,2)
        % down left
        x1=cols((i+1)/2,j);
        x2=cols((i+1)/2,j+1);
        % upper right
        y2=rows(i+1);
        y1=rows(i);
        % draw rectangle
        rect2P(x1,y1,x2,y2);
    end
end
        

function rect2P(x1,y1,x2,y2) % x1,y1 for down left corner, x2,y2 for upper right corner
width = abs(x2-x1);
height = abs(y2-y1);
rectangle('Position',[x1,y1,width,height],'Edgecolor','w');
