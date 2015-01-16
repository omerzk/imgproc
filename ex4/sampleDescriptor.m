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
%transfer feature coordinates to pyr{i + 2} domain 
pos = ((pos - 1) * 0.25) + 1;
%ataining the grad direction at every point of the image.
[~, dir] = imgradient(im , 'sobel');%soble is the default method

%make an index matrix which represents a window around the target pixel
[pY, pX] = meshgrid(-descRad: descRad, -descRad: descRad);

for l = 1: len
     x = pos(l, 1);
     y = pos(l, 2);

    indexVec = [pX(:) pY(:)]';
%     dirpatch = conv2(interp2(dir,pX+ x,pY + y), G, 'same');
%     lclOrient = dirpatch(4, 4);
    lclOrient = interp2(dir,   x,y);
    %Fabricate the opposite rotation matrix as to normalize the orientation to 0; 
    cosTheta = cos(lclOrient); sinTheta = sin(lclOrient);
    rotMat = [cosTheta -sinTheta; sinTheta cosTheta];
    if isnan(rotMat(1))%DEBUGGING only
        [lclOrient x y] %#ok<NOPRT>
        size(dir)
    end
    rotIndices = reshape(rotMat * indexVec,7,7,2);%r
    
    %with rotation
    %patch = interp2(Y, X, im, rotIndices(:,:,2) + y, rotIndices(:,:,1) + x,'cubic');
    %imshow(patch);
    %without rotation for DEBUGGING.
    patch = interp2(im, pX + x, pY + y,'cubic');
    desc(:, :, l) = (patch - mean(patch(:)))/norm(patch - mean(patch(:)));
end
end

