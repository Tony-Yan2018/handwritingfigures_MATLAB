function y=analyse(k) % maxinum k
metrics=zeros(k-9,4);
for i=10:k
    metrics(i-9,:) = Main(i);
end
x=linspace(10,k,k-9);
b=bar(x,metrics,0.6);
ylim([0.85,0.95]);
showEndVal(b,1)
showEndVal(b,2)
showEndVal(b,3)
showEndVal(b,4)
end

function showEndVal(b, num)
xtips = b(num).XEndPoints;
ytips = b(num).YEndPoints;
labels = string(b(num).YData);
text(xtips,ytips,labels,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
end