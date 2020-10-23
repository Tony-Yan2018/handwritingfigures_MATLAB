function y=addlines(pArr, im, offset)
[vLen, hLen] = size(im);
global num
imIn = im;
num=0;
null = find0(pArr, vLen); % first coordinates of 9 zero intervals
for i=1:num
    imIn = [imIn(1:null(i)-1+offset*(i-1),:);zeros(offset,hLen);imIn(null(i)+offset*(i-1):end,:)];
end
y=imIn;

function a=find0(arr,len)
global num
a = zeros(1,10);
for i=1:len-1
    if arr(i)>0 && arr(i+1)==0
         num = num+1;
        a(num) = i+1;
    end
end
a

        
        
        