function upSampled = upSample( im, dir)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
cols = 1;
rows = 0;

if(dir < 0 || dir>1)
    disp('invalid parameter');
end
sz = size(im);

if dir == rows
    upSampled = zeros(sz(1)*2,sz(2));
    upSampled(2:2:end, :) = im;
else
    upSampled = zeros(sz(1),sz(2)*2);
    upSampled(:, 2:2:end) = im;
end

end

