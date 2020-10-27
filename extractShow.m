function extractShow(im) % a string
im = 1-imbinarize(imread(im));
rows = getRows(im);% size = 1*20
columns = getColumns(im, rows);% size = [10,40]
drawRects(im,rows,columns);