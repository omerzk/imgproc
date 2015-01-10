function main(pyr1,pyr2)
[pos1,desc1] = findFeatures(pyr1,800);
[pos2,desc2] = findFeatures(pyr2,800);
[ind1,ind2] = myMatchFeatures(desc1,desc2, 0.7);
matched1 = pos1(ind1, :);
matched2 = pos2(ind2, :);
[~, inliers] = ransacTransform(matched1, matched2, 1000, 0.2);
displayTheMatches(pyr1{1}, pyr2{1}, matched1,matched2, inliers);
[matched1 matched2];
matchdesc1 = desc1(:,:,ind1);
matchdesc2 = desc2(:,:,ind2);
[matchdesc1 matchdesc2];

