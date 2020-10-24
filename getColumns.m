function cols = getColumns(im,rows)
for i=0:9
    cols(i+1,:) = getColumn(im,rows,i);
end


function y=getColumn(im,rows,index) % index from 0 to 9
rectangle = im(rows(2*index+1):rows(2*index+2),:); % get row rectangle of current number line
column = sum(rectangle, 1);
count=0;
for i=1+1:length(column)-1
    if column(i)==0 && (column(i+1)>0 || column(i-1)>0)
        count = count+1;
        y(count) = i;
    end
end
