function fourierImage = DFT2(image)
fourierImage = zeros(size(image));

for j= 1:length(image(1, :))
    fourierImage(:,j) = DFT(image(:,j)')';
end

for i= 1 : length(image(:, 1))
    fourierImage(i,:) = DFT(fourierImage(i,:));
end

end