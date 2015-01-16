imgDirectory = '../ass';
nViews = 20;
images = loadImages(imgDirectory);
%1.
T = register(images);
maxY = 0;maxX = 0;
%2. :)
panT = imgToPanoramaCoordinates(T);

for l=1:size(panT,2)
    maxX = ceil(max(maxX, panT{l}(1, 3))); maxY = ceil(max(maxY,panT{l}(2, 3)));
end
%3.:TODO

halfSliceWidth = (size(images(:, :, :, 1), 2) / nViews) / 2;
panoSize = size(images(:,:,:,1)) + [maxX maxY+ceil(halfSliceWidth)*2 0];%TODO: check!
sliceCenters = 1 + ones(1, size(images,4)) * halfSliceWidth +(0 : size(images,4)-1)*(halfSliceWidth*2);

frames = zeros([panoSize nViews]);
OkFrames = 1;
for k = 1:nViews
%4.:
[panoramaFrame,frameNotOK] = renderPanoramicFrame(panoSize, images, panT, ones(1, size(images,4))*sliceCenters(k),halfSliceWidth );

%5.:REVISE
if ~frameNotOK
    imshow(panoramaFrame);
    frames(: ,:, :, OkFrames) = panoramaFrame;
    OkFrames = OkFrames + 1;
end

end
stereoVid = immovie(frames(:, :, :, 1:OkFrames-1));