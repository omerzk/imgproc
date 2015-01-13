function [stereoVid] = createStereoVideo(imgDirectory, nViews) %
% This function gets an image directory and create a stereo movie with
% nViews. It does the following %
% 1. Match transform between pairs of images.
% 2. Convert the transfromations to a common coordinate system.
% 3. Determine the size of each panoramic frame.
% 4. Render each view.
% 5. Create a movie from all the views.
%
% Arguments:
% imgDirectory ? A string with the path to the directory of the images
% nView ? The number of views to extract from each image 
% Returns:
% stereoVid ? a movie which includes all the panoramic views 
images = loadImages(imgDirectory);
%1.
T = cell(1, size(images, 3) - 1);
maxY = 0;maxX = 0;
prevImages = images(:,:,:,1:end-1);
curImages = images(:,:,:,2:end);
parfor z = 2:(size(images, 4))
    [prevPyr, ~] = GaussianPyramid(rgb2gray(prevImages(:,:,:,z-1)),15,5);
    [curPyr, ~] = GaussianPyramid(rgb2gray(curImages(:,:,:,z-1)),15,5);
    
    [curPos, curDesc] = findFeatures(curPyr, 800);
    [prevPos, prevDesc] = findFeatures(prevPyr, 800);
    
    [prevInd, curInd] = myMatchFeatures(prevDesc, curDesc, 0.7);
    
    [H , ~] = ransacTransform(prevPos(prevInd, :), curPos(curInd, :), 700, 30);
    T{z-1} = H;
end

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
stereoVid = immovie(frames(:,:,:, 1:OkFrames-1));
end