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
[len, ~] = size(pos);
desc = zeros(k, k, len);
%transfer feature coordinates to pyr{i + 2} domain 
pos = ((pos - 1) * 0.25) + 1;
%make an index matrix which represents a window around the target pixel
[pY, pX] = meshgrid(-descRad: descRad, -descRad:descRad);

for l = 1: len
    x = pos(l, 1);
    y = pos(l, 2);
    patch = interp2(im, pX + x, pY + y,'cubic');
    desc(:, :, l) = (patch - mean(patch(:)))/norm(patch - mean(patch(:)));
end
end

