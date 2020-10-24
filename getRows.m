function y=getRows(im)
row = sum(im,2).';
count=0;
for i=2:length(row)-1
    if row(i)==0 && (row(i+1)>0 || row(i-1)>0)
        count = count+1;
        y(count) = i;
    end
end
