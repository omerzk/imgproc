function [imQuant, error] = quantizeImage(imOrig, nQuant, nIter)
% quantizeImage performs optimal quantization on the imOrig 
%   reduces the number of colors used to display imOrig to nQuant using
%   optimal quantization, while preforming nIter optimizations of z and q.
%   in an rgb image operates only on the Y cahnnel of the YIQ version 
MAX_Z = 256;

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
%loop until valid number of segments is reached
success = false;
while(~success)
    temp = cumhist;
    z = ones(1, nQuant + 1);
    z(nQuant + 1) = 256;
    success = true;
    try
        for i = 2: (nQuant)
            temp = temp - pixels_per_seg;
            f = find(temp((z(i-1) + 1): end) >= 0);
            z(i) = z(i - 1) + f(1);
        end
    catch
        nQuant = nQuant - 1;
        success = false;
    end
end
display(strcat('output nQuant  = ', int2str(nQuant)));



%Intitialize the error vector
error = zeros(1, nIter);
%Initiate the lookup table
lut = (1 : 256);
q = 0;
%EM
for j = 1: nIter
    prev_Q = q;prev_Z = z;
    q = arrayfun(@computeQ, z(1:(nQuant)), z(2: end));
    z(2: nQuant) = arrayfun(@computeZ, q(1:(end - 1)), q(2: end));
    error(j) = sum(arrayfun(@computeErr, z(1: (nQuant)), z(2: end), q));
    if(prev_Q == q)
        if (prev_Z == z)
            break;
        end
    end     
end

%populate the lookup table
arrayfun(@makelut, z(1: (nQuant)), z(2: end) , q, 'UniformOutput', false);
%quantize the image using the lut.
imQuant = lut(channel + 1)/255;

%revert to truecolor
if truecolor
    imYIQ(:,:,1) = imQuant;
    imQuant = transformYIQ2RGB(imYIQ);
end

figure('name', strcat('imQuant image in  ',int2str(nQuant), ' colors'),'NumberTitle', 'off'); imshow(imQuant);
figure('name', 'Error','NumberTitle', 'off');
plot(error); xlabel('Iteration'); ylabel('Error'); title('Error Graph')


function  makelut(zi, zi_1, qi)
    %makelut computes a subvector of the lut vector
    %and inserts it into the lut.
    lut(zi : zi_1) = ones(1, zi_1 - zi+1) * qi;    
end

function qi = computeQ(zi , zi_1)
    %computeQ computes the qi value when given zi and zi+1
    %using the optimal quantization taught in class.
    if zi_1 == MAX_Z
        zVec = (zi: zi_1);
    else
        zVec = (zi: zi_1 - 1);
    end
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
    if zi_1 == MAX_Z
        zVec = (zi: zi_1);
    else
        zVec = (zi: zi_1 - 1);
    end
    erri = sum(((qi - zVec).^2).* hist(zVec)');
end
end

