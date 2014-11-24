function image = IDFT2(fourierImage)
    image = zeros(size(fourierImage));
for j= 1:length(image(:, 1))
    image(:,j) = IDFT(fourierImage(:,j)')';
end


for i= 1 : length(image(1, :))
    image(i,:) = IDFT(image(i,:));
end
end