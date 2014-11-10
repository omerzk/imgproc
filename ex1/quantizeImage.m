function [imQuant, error] = quantizeImage(imOrig, nQuant, nIter)
% quantizeImage performs optimal quantization on the imOrig 
%   reduces the number of colors used to display imOrig to nQuant using
%   optimal quantization, while preforming nIter optimizations of z and q.
%   in an rgb image operates only on the Y cahnnel of the YIQ version 

%Input checks
if(nQuant <= 0 || nIter <= 0)
    display('nQuant and nIter must be positive integers');
    imQuant = imOrig;
    error = 0;
    return 
end

if(~isfloat(imOrig))
    imOrig = im2double(imOrig);
end
%===========================================================

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

%Initiate the z vector
z = ones(1,nQuant + 1);
z(nQuant + 1) = 256;
temp = cumhist;
for i = 2: (nQuant)
    temp = temp - pixels_per_seg;
    f = find(temp((z(i-1) + 1): end) >= 0);
    z(i) = z(i - 1) + f(1);
end

%Intitialize the error vector
error = zeros(1, nIter);
%Initiate the lookup table
lut = (1 : 256);

%EM
for j = 1: nIter
    q = arrayfun(@computeQ, z(1:(nQuant)), z(2: end));
    z(2: nQuant) = arrayfun(@computeZ, q(1:(nQuant - 1)), q(2: end));
    error(j) = sum(arrayfun(@computeErr, z(1: (nQuant)), z(2: end), q));
end

%populate the lookup table
arrayfun(@makelut, z(1: (nQuant)), z(2: end) , q, 'UniformOutput', false);
%quantize the image using the lut.
imQuant = lut(channel + 1)/255;

if truecolor
    imYIQ(:,:,1) = imQuant;
    imQuant = transformYIQ2RGB(imYIQ);
end

figure('name', 'imQuant image','NumberTitle', 'off'); imshow(imQuant);
figure('name', 'Error','NumberTitle', 'off');
plot(error); xlabel('Iteration'); ylabel('Error'); title('Error Graph')


function  makelut(zi, zi_1, qi)
    %makelut computes a subvector of the lut vector
    %and inserts it into the lut.
    lut(zi : zi_1 - 1) = ones(1, zi_1 - zi) * qi;    
end

function qi = computeQ(zi , zi_1)
    %computeQ computes the qi value when given zi and zi+1
    %using the optimal quantization taught in class.
    zVec = (zi: zi_1);
    histVec = hist(zVec);
    qi = round((sum(zVec * histVec))/sum(histVec));
end

function zi = computeZ(qi, qi_1)
    %computeQ computes the zi value when given qi and qi+1
    %using the optimal quantization taught in class.
    zi = round((qi+qi_1)/2);
end

function erri = computeErr(zi, zi_1, qi)
    %computeErr computes a section's error value when given zi, zi+1 and qi.
    %using the optimal quantization taught in class.
    zVec = (zi: zi_1);
    erri = sum(((qi - zVec).^2).* hist(zVec)');
end
end

