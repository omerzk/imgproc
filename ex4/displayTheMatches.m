function displayTheMatches(im1,im2,pos1,pos2,inlind)
% DISPLAYMATCHES Display matched pt. pairs overlayed on given image pair. % Arguments:
% im1,im2 ? two grayscale images
% pos1,pos2 ? nx2 matrices containing n rows of [x,y] coordinates of matched
% points in im1 and im2 (i.e. the i?th match?s coordinate is
% pos1(i,:) in im1 and and pos2(i,:) in im2).
% inlind ? k?element array of inlier matches (e.g. see output of
% ransacHomography.m)


%showMatchedFeatures(im1, im2,pos1, pos2,'montage')

im = [im1,im2];
pos2(:, 2) = pos2(:, 2) + size(im1, 2);
figure;imshow(im);
hold on
j = 1;
for i= 1 : size(pos1,1)
    if j<=size(inlind,2) && i == inlind(j)
      plot([pos1(i,2),pos2(i,2)],[pos1(i,1),pos2(i,1)], 'y')
      j = j + 1;
    else
      plot([pos1(i,2),pos2(i,2)],[pos1(i,1),pos2(i,1)])
    end
end
hold off;
