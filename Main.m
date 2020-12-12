im = 1-imbinarize(imread('app.tif'));
imtest = 1-imbinarize(imread('test.tif'));
classifier1 = posteriorProbs(im,imtest,5);
zonvect = zoningVects(im,5,5);
classifier2 = probKNNAll(imtest,5,5,11,zonvect);

% sum combination
prob_sum = zeros(10,10,10);
comb_sum = classifier1 + classifier2;

for row = 1:10
    for col = 1:10
        for class = 1:10
        denominator_sum=sum(comb_sum(row,col,:)); % always =2
        nominator_sum=comb_sum(row,col,class);
        prob_sum(row,col,class)=nominator_sum/denominator_sum;
        end
    end
end

% product combination
prob_prod = zeros(10,10,10);
comb_prod = classifier1.*classifier2;
for row = 1:10
    for col = 1:10
        for class = 1:10
        denominator_prod=sum(comb_prod(row,col,:)); 
        nominator_prod=comb_prod(row,col,class);
        prob_prod(row,col,class)=nominator_prod/denominator_prod;
        end
    end
end

res_sum = getResult(prob_sum);
res_prod = getResult(prob_prod);

sumResult=res_sum
sum_acc=accuracy(res_sum)
confusionMatrixOfSum=confusion_matrix(res_sum)
metricsSum=metric_eval(confusionMatrixOfSum)

prodResult=res_prod
prod_acc=accuracy(res_prod)
confusionMatrixOfProd=confusion_matrix(res_prod)
metricsProd=metric_eval(confusionMatrixOfProd)

function res=getResult(prob)
res = zeros(10,10);
for i = 1:10
    for j =1:10        
        res(i,j)=findMax(prob(:,j,i));
    end    
end
end

function y=accuracy(res)
correct=0;
for row=1:10
    for col=1:10
        if res(row,col)==(row-1)
            correct=correct+1;
        end
    end
end
y=correct/100;
end

function y=confusion_matrix(res)
y=zeros(10,10);
for row=1:10
    for col=1:10
        if res(row,col)==(row-1)
            y(row,row)=y(row,row)+1;
        else
            y(res(row,col)+1,row)=y(res(row,col)+1,row)+1;
        end
    end
end
end

function y=metric_eval(matrix) % returns 
precision=zeros(1,10);
recall=zeros(1,10);
F1=zeros(1,10);
% calc recall
for col=1:10
    denominator = sum(matrix(:,col));
	recall(col)=matrix(col,col)/denominator;
end
%calc precision
for row=1:10
    denominator = sum(matrix(row,:));
    precision(row)=matrix(row,row)/denominator;
end
% calc F1
for i=1:10
    preci = precision(i);
    rec = recall(i);
    F1(i)=(2*preci*rec)/(preci+rec);
end
macroF1=mean(F1);
microF1=sum(diag(matrix))/sum(matrix,'all');
y=[macroF1, microF1];
end





