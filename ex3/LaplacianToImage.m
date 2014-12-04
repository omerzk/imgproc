function img = LaplacianToImage(lpyr, filter, coeffMultVec)
    coeffCell = num2cell(coeffMultVec);    
    coLpyr = cellfun(@(x,y){x*y} , lpyr, coeffCell);
    shifted = coLpyr(2 : end);
    shifted(1,end+1) = {zeros(length(coLpyr{end})/2)};
    cells =cellfun(@(x,y){x + expand(y)} , coLpyr, shifted)
    img = sum(cellfun(@(x,y){x + expand(y)} , coLpyr, shifted));
    
    function  expansion = expand(level)
        padding = zeros(size(level) * 2);
        padding(1:2:end,1:2:end) = level;
        expansion = conv2(conv2(padding, filter, 'same'),filter','same');
    end
end