function imgs = loadImages(directoryPath)
% Read all images from directoryPath
%
% Arguments:
% directoryPath ??? A string with the directory path
%
% Returns
% imgs ??? 4 dimensional vector, where imgs(:,:,:,k) is the k???th
% image in RGB format.
%
filels = dir(directoryPath);
imls = filels(cell2mat(cellfun(@(x){strcmp(x,'..') == strcmp(x,'.')}, {filels(:).name}))); 
info = imfinfo(strcat(directoryPath, '/', imls(1).name));
imgs = zeros(info.Height , info.Width, info.BitDepth / 8, length(imls));
for i = 1 : length(imls)
    im = imls(i);
    imgs(:,:,:,i) = im2double(imread(strcat(directoryPath, '/', im.name)));
end

end

