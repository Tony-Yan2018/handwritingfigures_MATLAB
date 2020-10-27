function v=vectN(im, k)% returns the characteristic vector of a number N
sampleRows = round(linspace(1,size(im,1),k));% to get an integer
width = size(im,2);
left = zeros(1,k);
right = zeros(1,k);
for i=1:k
    row=im(sampleRows(i),:);
    % left profile
    for j=1:length(row)-1
        if(row(j)~=0)
            continue;% No gap on the edge
        end
        if row(j)==0 && row(j+1)>0
            left(i) = (j+1)/width; % normalization
            continue; % prohibit a wrong second projection
        end
    end
    % right profile
    for j=length(row):-1:2
        if(row(j)~=0)
            continue;% No gap on the edge
        end
        if row(j)==0 && row(j-1)>0
            right(i) = (width-j+1)/width;% normalization
            continue;% prohibit a wrong second projection
        end
    end
end
v=[left,right];