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

unfilteredImages = loadImages(imgDirectory);
%1.
T = register(unfilteredImages);
maxY = 0; maxX = 0;
%2.
unfilteredPanT = imgToPanoramaCoordinates(T);
%filter negative movements
images = zeros(size(unfilteredImages));
panT = cell(size(unfilteredPanT));
prev = zeros(3, 3);
valid = 1;
for l=1:size(unfilteredPanT,2)
    cur = unfilteredPanT{l};
    if prev(1, 3) <= cur(1, 3)
        images(:,:,:, valid) = unfilteredImages(:,:,:,l);
        panT{valid} = cur;
        valid  = valid + 1;
        %compute maximal translation in each axis
        maxX = ceil(max(maxX, cur(2, 3))); maxY = ceil(max(maxY,cur(1, 3)));
    end
    prev = cur;
end

%3.: Calculate slice centers width and panorama size

halfSliceWidth = round((size(images(:, :, :, 1), 2) / nViews) / 2);
panoSize = size(images(:,:,:,1)) + [maxX maxY+ceil(halfSliceWidth)*2   0];
sliceCenters = 1 + ones(1, size(images,4)) * halfSliceWidth +(0 : size(images,4)-1)*(halfSliceWidth*2);

%4.: Produce the panorama frames
frames = zeros([panoSize nViews]);
OkFrames = 1;
for k = 1:nViews
[panoramaFrame,frameNotOK] = renderPanoramicFrame(panoSize, images,panT, ones(1, size(images,4))*sliceCenters(k),halfSliceWidth );

%5.:MovieMaker
if ~frameNotOK
    frames(: ,:, :, OkFrames) = panoramaFrame;
    OkFrames = OkFrames + 1;
end

end
stereoVid = immovie(frames(:, :, :, 1:OkFrames-1));
end