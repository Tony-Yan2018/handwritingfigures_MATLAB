function extractShow(im) % a string
im = 1-imbinarize(imread(im));
rows = getRows(im);
columns = getColumns(im, rows);
drawRects(im,rows,columns);