function [imQuant, error] = quantizeImage(imOrig, nQuant, nIter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure('name', 'Original image','NumberTitle', 'off');
imshow(imOrig);

if ndims(imOrig) == 3
    imYIQ = transformRGB2YIQ(imOrig);
    channel = im2uint8(imYIQ(:, :, 1));
    truecolor = true;
else
    channel = im2uint8(imOrig);
    truecolor = false;
end

%determine the initial division - z
hist = imhist(channel);
cumhist = cumsum(hist);
pixels_per_seg = round(cumhist(256,1)/nQuant);
%z = find(mod(cumhist,pixels_per_seg) == 0);
z = ones(1,nQuant + 1);
z(nQuant + 1) = 256;
dcumhist = double(cumhist);%is this necessary?????????======, done so there could be negative values.
for i= 2: (nQuant)%idk
    dcumhist = dcumhist - pixels_per_seg;
    f = find(dcumhist((z(i-1) + 1):256) >= 0);
    z(i) = z(i-1) + f(1);
end

%intitialize the error array
error = zeros(1, nIter);
% initiate the lookup table
lut = (1:256);
%EM
for j=1: nIter
    %size(z)
    q = arrayfun(@computeQ, z(1:(nQuant)), z(2: nQuant + 1));
    z(2: nQuant) = arrayfun(@computeZ, q(1:(nQuant - 1)), q(2: nQuant));
    error(j) = computeErr(z, q, nQuant);
end
arrayfun(@makelut, z(1: (nQuant)), z(2:end) , q, 'UniformOutput', false);
imQuant = lut(channel + 1)/255;
if truecolor
    imYIQ(:,:,1) = imQuant;
    imQuant = transformYIQ2RGB(imYIQ);
end

figure('name', 'imQuant image','NumberTitle', 'off');
imshow(imQuant);

function  makelut(zi,zi1, qi)
    lut(zi : zi1-1) = ones(1, zi1 - zi) * qi;    
end

function qi = computeQ(zi , zi1)
    zVec = (zi:zi1);
    histVec = hist(zVec);
    qi = round((sum(zVec * histVec))/sum(histVec));%is round needed
    %qi = symsum(hist(k) * k, k, [zi; zi1])/(symsum(hist(l), l, [zi; zi1]));
end

function zi = computeZ(qi, qi1)
    zi = round((qi+qi1)/2);
end

function erri = computeErr(z, q, nQuant)
    %sym p m
    erri=1;
    %erri = symsum(symsum(((q(p) - m)^2)*hist(k),m , [z(p);z(p + 1)]), p,[1; nQuant]);    
end
end

