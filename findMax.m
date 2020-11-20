function y = findMax(array)
max = 0;
y=0;
for i=1:length(array)
    if max<array(i)
        y=i-1;
        max=array(i);
    end
end
