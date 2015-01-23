function  expansion = expand(level, filter)
   %expand returns the input level of a pyramid after expansion 
    padding = zeros(size(level) * 2);
    padding(1:2:end,1:2:end) = level;
    expansion = conv2(conv2(padding, filter, 'same'),filter','same');
end
