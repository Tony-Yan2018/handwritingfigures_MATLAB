im = 1-im2bw(imread('app.tif'));
imtest = 1-im2bw(imread('test.tif'));
classifier1 = posteriorProbs(im,imtest,5);
zonvect = zoningVects(im,5,5);
classifier2 = probKNNAll(imtest,5,5,5,zonvect);

%PS CALCULATION
ps = classifier1 + classifier2;
for i = 1:10  
    for j=1:10
    sum1 = sum(ps(:,j,i),1);
    
    ps(:,j,i)=ps(:,j,i)/(sum1);    
    end
end

%PP CALCULATION
pp = classifier1.*classifier2;
for i = 1:10  
    for j=1:10
    sum2 = sum(pp(:,j,i),1);
    if sum2==0
        
    else
        pp(:,j,i)=pp(:,j,i)/(sum2);  
    end
    end    
end

for i = 1:10
    for j =1:10        
        resultpp(i,j)=findMax(pp(:,j,i));
    end    
end
disp(resultpp);

for i = 1:10
    for j =1:10        
        resultps(i,j)=findMax(ps(:,j,i));
    end    
end
disp(resultps)







