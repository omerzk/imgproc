function pos = spreadOutCorners(im,n,m,maxNumCorners)
% SPREADOUTCORNERS Detects Harris corners in an nxm grid of sub-images of im.
%
% Syntax:
% pos = spreadOutCorners(im,n,m,maxNumCorners)
%
% Arguments: 
% im - Grayscale image in which to search for Harris corners.
% n - Number of vertical sub-images to decompose im into.
% m - Number of horizontal sub-images to decompose im into.
% maxNumCorners - Maximal number of corners to detect in total.
% 
% Returns:
% pos - A kx2 matrix of [x,y] corner coordinates per row detected in im.
%
% Description:
% By running Matlab's Harris corner detector on seperate sub-images of a
% given image, spreadOutCorners is able to avoid returning corners
% concentrated in a small region of the image. This may have otherwise
% occured if maxNumCorners corners, having heighest Harris score, were
% concentrated in a small image region.

numFound = 0;
pos = zeros(maxNumCorners,2); % preallocate pos

% Harris will find at most siMaxNumCorners number of corners per sub-image
siMaxNumCorners = floor(maxNumCorners/(n*m)); 
siWidth = floor(size(im,2)/m);  % sub-image width and height
siHeight = floor(size(im,1)/n); %
xbound = [1+(0:m-1)*siWidth,size(im,2)];  % boundary coords of sub-images
ybound = [1+(0:n-1)*siHeight,size(im,1)]; %

for j=1:numel(xbound)-1   % for all sub-images
  for i=1:numel(ybound)-1 %
    subIm = im(ybound(i):ybound(i+1),xbound(j):xbound(j+1));
    subImPos = corner(subIm,'Harris',siMaxNumCorners);
    subImPos(:,1) = subImPos(:,1)+xbound(j)-1;
    subImPos(:,2) = subImPos(:,2)+ybound(i)-1;
    currNumFound = size(subImPos,1);
    pos(numFound+1:numFound+currNumFound,:) = subImPos;
    numFound = numFound+currNumFound;
  end
end

pos = pos(1:numFound,:); % get rid of the trailing zeros
