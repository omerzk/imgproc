function desc = sampleDescriptor(im,pos,descRad)
% SAMPLEDESCRIPTOR Sample a MOPS?like descriptor at given position in image. % Arguments:
% im ? nxm grayscale image to sample within.
% pos ? A nx2 matrix of [x,y] descriptor positions in im.
% descRad ? ?Radius? of descriptors to compute (see below).
% Returns:
% desc ? A kxkxn 3?d matrix co^(-2)ntaining the ith descriptor
% at desc(:,:,i). The per?descriptor dimensions kxk are related to the
% descRad argument as follows k = 1+2?descRad.
k = 7;
G = fspecial('gaussian', [7 7], 2);
%ataining the grad direction at every point of the image.
%soble is the default method
%blur to smooth the gradient.
[~, dir] = imgradient(conv2(im, G, 'same'), 'sobel');
[len, ~] = size(pos);
desc = zeros(k, k, len);
%transfer feature coordinates to pyr{3} domain 
pos = (pos - 1)*(2^(-2)) + 1;
%fabricate the origin coordinates
sz = size(im);
[Y, X] = meshgrid(1:sz(2), 1:sz(1));

for l = 1: len
    x = pos(l, 1);
    y = pos(l, 2);
    curDir = interp2(Y, X, im, y, x);
    cosTheta = cos(curDir); sinTheta = sin(curDir);
    %calculate the rotation matrix
    %no need for homogunos coordinates
    rotMat = [cosTheta -sinTheta; sinTheta cosTheta];
    %make an index matrix which represents a window afound the target pixel
    patchY = meshgrid(1:(descRad * 2) + 1, 1: (descRad * 2) + 1) - 4;
    patchInd(:, :, 2) = patchY;%+ y;
    patchInd(:, :, 1) = patchY'; %+ x;
    patch = zeros(7, 7);
    for m = 1:7
        for k = 1:7
            %backward warping...
            %FIND THE X',Y' after rotation.
            rotInd = rotMat * [patchInd(m, k, 1); patchInd(m, k, 2)];
            rotInd(1)=  rotInd(1) + x;
            rotInd(2)=  rotInd(2) + y;
            patch(m, k) = interp2(Y, X, im, rotInd(2), rotInd(1));
        end
    end
    %normalize
    desc(:, :, l) = (patch - mean(patch(:)))/norm(patch - mean(patch(:)));
end

