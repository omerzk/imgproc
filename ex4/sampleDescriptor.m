function desc = sampleDescriptor(im,pos,descRad)
% SAMPLEDESCRIPTOR Sample a MOPS?like descriptor at given position in image. % Arguments:
% im ? nxm grayscale image to sample within.
% pos ? A nx2 matrix of [x,y] descriptor positions in im.
% descRad ? ?Radius? of descriptors to compute (see below).
% Returns:
% desc ? A kxkxn 3?d matrix co^(-2)ntaining the ith descriptor
% at desc(:,:,i). The per?descriptor dimensions kxk are related to the
% descRad argument as follows k = 1+2?descRad.
k = 1 + 2 * descRad;
G = fspecial('gaussian', [7 7], 2);
%ataining the grad direction at every point of the image.
%soble is the default method
%blur to smooth the gradient.
[~, dir] = imgradient(conv2(im, G, 'same'), 'sobel');
[len, ~] = size(pos);
desc = zeros(k, k, len);
%transfer feature coordinates to pyr{i + 2} domain 
pos = (pos - 1)*(2^(-2)) + 1;
%fabricate the origin coordinates
sz = size(im);
[Y, X] = meshgrid(1:sz(1), 1:sz(2));

for l = 1: len
    x = pos(l, 1);
    y = pos(l, 2);
    curDir = interp2(Y, X, dir, y, x);%consider changing to dominant/blurred gradient
    cosTheta = cos(curDir); sinTheta = sin(curDir);
    rotMat = [cosTheta -sinTheta; sinTheta cosTheta];
    %make an index matrix which represents a window afound the target pixel
    patchY = meshgrid(1: k, 1: k) - 4;
    patchInd(:, :, 2) = patchY;
    patchInd(:, :, 1) = patchY';
    patch = zeros(7, 7);
    for m = 1:7
        for r = 1:7
            %backward warping...
            %FIND THE X',Y' after rotation.
            %:TODO im not sure wether the inverse transform is needed or the
            %opposite 
            rotInd = inv(rotMat) * [patchInd(m, r, 1); patchInd(m, r, 2)];
            rotInd(1)=  rotInd(1) + x;
            rotInd(2)=  rotInd(2) + y;
            patch(m, r) = interp2(Y, X, im, rotInd(2), rotInd(1));
        end
    end
    desc(:, :, l) = patch;
end

