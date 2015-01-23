function img = LaplacianToImage(lpyr, filter, coeffMultVec)
% produces the original image~ when provided with it's laplacian pyramid
% and the gausssian filter used in constructing the pyramid could be used
% to add filtering by manipulating the coefficient vector
    coeffCell = num2cell(coeffMultVec);    
    % multiply each level of the pyramid with the relevant coefficient
    coLpyr = cellfun(@(x,y){x * y} , lpyr, coeffCell');
    filter = filter*2; % since the forum directed the input filter is the gaussian one. 
    %add the levels up from the last to the first.
    for i = length(coLpyr):-1:2
         coLpyr{i - 1} = expand(coLpyr{i}, filter) + coLpyr{i - 1};
    end
    img = coLpyr{1};

end