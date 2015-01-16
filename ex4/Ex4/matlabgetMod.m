function H = matlabgetMod(origin, dist)

original  = rgb2gray(origin);
distorted  = rgb2gray(dist);

ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);

[featuresOriginal,   validPtsOriginal] = extractFeatures(original,  ptsOriginal);
[featuresDistorted, validPtsDistorted] = extractFeatures(distorted, ptsDistorted);

index_pairs = matchFeatures(featuresOriginal, featuresDistorted);

matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));

figure; showMatchedFeatures(original,distorted,matchedPtsOriginal,matchedPtsDistorted);

title('Matched SURF points, including outliers');
[tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'similarity');
figure; showMatchedFeatures(original,distorted,inlierPtsOriginal,inlierPtsDistorted);
title('Matched inlier points');
H = tform.T';