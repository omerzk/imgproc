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
[prevPyr, ~] = GaussianPyramid(images(:,:,:,1),15,5);
[prevPos, prevDesc] = findFeatures(prevPyr, 800);
T = zeros(1, size(images, 3) - 1);

for z = 2:size(images, 3)
    [curPyr, ~] = GaussianPyramid(images(:,:,:,z),15,5);
    [curPos, curDesc] = findFeatures(curPyr, 800);
    [prevInd, curInd] = myMatchFeatures(prevDesc, curDesc, 0.7);
    [H , ~] = ransacTransForm(prevPos(prevInd, :), curPos(curInd, :), 500, 0.2);
    T{z} = H;
end
%2. :)
panT = imgToPanoramaCoordinates(T);

%3.:TODO

%4.:REVISE
[panoramaFrame,frameNotOK] = renderPanoramicFrame(panoSize,images,panT,imgSliceCenterX,halfSliceWidthX);
%5.:REVISE
if ~frameNotOK
    stereoVid(k) = panoramaFrame;

end