function [T,inliers] = ransacTransform(pos1,pos2,numIters,inlierTol)%the F is misplaced!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% Fit transform to maximal inliers given point matches
% using the RANSAC algorithm.
%
% Arguments:
% pos1,pos2 ??? Two nx2 matrices containing n rows of [x,y] coordinates of
% matched points.
% numIters ??? Number of RANSAC iterations to perform.
% inlierTol ??? inlier tolerance threshold. When determining if a given match,
% e.g. between pos1(i,:) and pos2(i,:), is an inlier match, the squared euclidean
% distance between the transformed pos1(i,:) and pos2(i,:) is computed and
% compared to inlierTol. Matches having this squared distance smaller than
% inlierTol are treated as inliers.
%
% Returns:
% T ??? A 3x3 matrix, where T(1,3) is dX and T(2,3) is dY.
% inliers ??? An array containing the indices in pos1/pos2 of the maximal set of
% inlier matches found.
%
% Description:
% To determine if a given match, e.g. between pos1(i,:) and pos2(i,:), is an
% inlier match, the squared euclidean distance between the transformed pos1(i,:)
% and pos2(i,:) is computed and compared to inlierTol


%i actually need only 2 point's but i decided to make my method as robust
%as pssible meaning account for the possibility of there being a more
%complex transform
s = 3; 
[npts,~] = size(pos1);
indices = (1:npts);
inliersThreshold = 7;
T = nan;
inliers = nan;
Hom = [pos1 ones(npts, 1)]';
for k = 1:numIters
    %Draw random points
    sampleInd = randsample(npts, s);
    sourcePts = pos1(sampleInd, :); targetPts = pos2(sampleInd, :);
    %Solve for a Homography
    H_ = getModel(sourcePts, targetPts);
    %Transform the source points
    homRes = (H_ * Hom)';
    %Remove homogenous coordinate x = x'/w, y = y'/w
    res = (homRes(:,1:2) ./ repmat(homRes(:,3),[1,2]));
    %Check for inliers
    %using squared euclidian distance as a metric and a thershold
    inlierCheck = ((sum((res - pos2).^2, 2)) < inlierTol)'; 
    if sum(inlierCheck) > inliersThreshold
        inliersThreshold = sum(inlierCheck);
        inliers = indices(inlierCheck);
    end
end

if isnan(inliers)
    disp('no model found for given tolerence');
%    T = eye(3);
else
    %Revaluate H using the inlier set 
    sourcePts = pos1(inliers, :); targetPts = pos2(inliers, :);
    T = getModel(sourcePts, targetPts);

end
end


