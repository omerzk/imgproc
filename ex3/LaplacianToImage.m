function img = LaplacianToImage(lpyr, filter, coeffMultVec)
    coeffCell = num2cell(coeffMultVec);    
    coLpyr = cellfun(@(x,y){x * y} , lpyr, coeffCell);
    %shifted = coLpyr(2 : end);
    filter = filter*2; % since the forum directed the input filter is the gaussian one. 
    %shifted(1,end+1) = {zeros(length(coLpyr{end})/2)};
    %cells = cellfun(@(x,y){x + expand(y)} , coLpyr, shifted)
    for i=length(coLpyr):-1:2
         coLpyr{i - 1} = expand(coLpyr{i}) + coLpyr{i - 1};
    end
    img = coLpyr{1};
    
    function  expansion = expand(level)
        padding = zeros(size(level) * 2);
        padding(1:2:end,1:2:end) = level;
        expansion = conv2(conv2(padding, filter, 'same'),filter','same');
    end
end