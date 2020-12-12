% returns the probability vector of a test sample
function y = probKNN(distArr,k)
distArr = sort(distArr, 2); % ascending sort of distance array
pickArr = zeros(1,10);% head pointer(the next item of a class) & class frequency indicator
km=k;
while k>0
    smallest = 100000;
    index = 0;
    % traverse the first uncalculated element of each class (0-9)
    for i = 1:10
        current = distArr(i,pickArr(i)+1);
        if current<smallest
            smallest = current;
            index = i;
        end
    end
    pickArr(index) = pickArr(index)+1; % index: class of the smallest (nearest) element after each iteration
    k=k-1;
end
y=pickArr/km;