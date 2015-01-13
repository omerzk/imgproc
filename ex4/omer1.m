
imgs = loadImages('sad');
T = cell(1, size(imgs, 4) - 1);
[prevPyr, ~] = GaussianPyramid(rgb2gray(imgs(:,:,:,1)),15,5);
[prevPos, prevDesc] = findFeatures(prevPyr, 800);
maxY = 0;maxX = 0;
for z = 2:size(imgs, 4)
    [curPyr, ~] = GaussianPyramid(rgb2gray(imgs(:,:,:,z)),15,5);
    [curPos, curDesc] = findFeatures(curPyr, 800);
    [prevInd, curInd] = myMatchFeatures(prevDesc, curDesc, 0.7);
    [H , ~] = ransacTransform(prevPos(prevInd, :), curPos(curInd, :), 1177, 0.5);
    maxX = max(maxX, H(1, 3)); maxY = max(maxY,H(2, 3));
    T{z-1} = H;
end
T = imgToPanoramaCoordinates(T);

panoSize = [400 1200];
center = round(size(imgs, 2)/2);
imgSliceCenterX = ones(1, size(imgs, 4))*center;
halfSliceWidthX = center - 1;

[panoramaFrame,frameNotOK]=renderPanoramicFrame(panoSize,imgs,T,imgSliceCenterX,halfSliceWidthX);
imshow(panoramaFrame);