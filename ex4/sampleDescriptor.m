function desc = sampleDescriptor(im,pos,descRad)
% SAMPLEDESCRIPTOR Sample a MOPS?like descriptor at given position in image. % Arguments:
% im ? nxm grayscale image to sample within.
% pos ? A nx2 matrix of [x,y] descriptor positions in im.
% descRad ? ?Radius? of descriptors to compute (see below).
% Returns:
% desc ? A kxkxn 3?d matrix co^(-2)ntaining the ith descriptor
% at desc(:,:,i). The per?descriptor dimensions kxk are related to the
% descRad argument as follows k = 1+2?descRad.

%init 
k = 1 + 2 * descRad;
G = fspecial('gaussian', [7 7], 2);
[len, ~] = size(pos);
desc = zeros(k, k, len);
%fabricate the origin coordinates
sz = size(im);
[Y, X] = meshgrid(1:sz(2), 1:sz(1));%why reverse?2,1 y,x?
%transfer feature coordinates to pyr{i + 2} domain 
pos = ((pos - 1) * 0.25) + 1;
%ataining the grad direction at every point of the image.
[~, dir] = imgradient(im , 'sobel');%soble is the default method

for l = 1: len
    x = pos(l, 1);
    y = pos(l, 2);
    %make an index matrix which represents a window around the target pixel
    [pY, pX] = meshgrid(1: k, 1: k);
    indexVec = [pX(:) pY(:)]' - 4;
    dirpatch = conv2(interp2(Y, X, dir, pY + y, pX + x), G, 'same');%consider changing to dominant/blurred gradient
    curDir = dirpatch(4, 4);
    cosTheta = cos(curDir); sinTheta = sin(curDir);
    rotMat = [cosTheta -sinTheta; sinTheta cosTheta];
    if isnan(rotMat(1))%DEBUGGING only
        [curDir x y]
        size(dir)
    end
    rotIndices = reshape(rotMat \ indexVec,7,7,2);
    

% REMOVE after implementing rotation.====================================
% %     rotX = zeros(k,k);rotY = zeros(k,k);
% %     for m = 1:7
% %         for r = 1:7
% %             %backward warping...
% %             %FIND THE X',Y' after rotation.
% %             %:TODO inv/reg?
% %             rotInd = rotMat \ [patchInd(m, r, 1); patchInd(m, r, 2)];
% %             rotX(m, r) =  rotInd(1) + x;
% %             rotY(m, r) =  rotInd(2) + y;
% %         end
% %     end
%=========================================================================
    %with rotation
    %patch = interp2(Y, X, im, rotIndices(:,:,2) + y, rotIndices(:,:,1) + x,'cubic');
    %without rotation for DEBUGGING.
    patch = interp2(Y, X, im, pY+y, pX+x,'cubic');
    desc(:, :, l) = (patch - mean(patch(:)))/norm(patch - mean(patch(:)));
end
end

