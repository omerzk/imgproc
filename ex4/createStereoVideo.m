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
[prevPyr, ~] = GaussianPyramid(rgb2gray(images(:,:,:,1)),15,5);
[prevPos, prevDesc] = findFeatures(prevPyr, 800);
T = cell(1, size(images, 3) - 1);
maxY = 0;maxX = 0;
for z = 2:size(images, 4)
    [curPyr, ~] = GaussianPyramid(rgb2gray(images(:,:,:,z)),15,5);
    [curPos, curDesc] = findFeatures(curPyr, 800);
    [prevInd, curInd] = myMatchFeatures(prevDesc, curDesc, 0.7);
    [H , ~] = ransacTransform(prevPos(prevInd, :), curPos(curInd, :), 500, 0.2);
    maxX = max(maxX, H(1, 3)); maxY = max(maxY,H(2, 3));
    T{z-1} = H;
end
%2. :)
panT = imgToPanoramaCoordinates(T);

%3.:TODO
panoSize = size(images(:,:,1)) + [maxX maxY];%TODO: check!
halfSliceWidth = (size(images(:, :, :, 1), 2) / nViews) / 2;
sliceCenters = ones(1, nViews) * halfSliceWidth +(0 : nViews-1)*(halfSliceWidth*2)

frames = zeros([panoSize nViews]);
OkFrames = 1;
for k = 1:nViews
%4.:
[panoramaFrame,frameNotOK] = renderPanoramicFrame(panoSize, images, panT, ones(1,nViews)*sliceCenters(k),halfSliceWidth );
%5.:REVISE
if ~frameNotOK
    frames(OkFrames) = panoramaFrame;
    OkFrames = OkFrames + 1;
end

end
stereoVid = immovie(frames(:,:, 1:OkFrames));
end