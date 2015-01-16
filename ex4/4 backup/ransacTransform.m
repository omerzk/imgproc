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
s = 4; 
[npts,~] = size(pos1);
indices = (1:npts);
best_inliers = 0;
inliersThreshold = 7;
T = nan;
inliers = nan;
for k = 1:numIters
    %Draw random points
    sampleInd = randsample(npts, s);
    sourcePts = pos1(sampleInd, :); targetPts = pos2(sampleInd, :);
    %Solve for a Homography
    H_ = getModel(sourcePts, targetPts);
    %Transform the source points
    Hom = [pos1'; ones(1, npts)];
    homRes = (H_ * Hom)';
    %Remove homogenous coordinate x = x'/w, y = y'/w
    res = (homRes(:,1:2) ./ repmat(homRes(:,3),[1,2]));
    %Check for inliers
    %inliers =  # (?((x1 - x2)? + (y1 - y2)?) > inlierTol)
    inlierCheck = ((sum((res - pos2).^2, 2)) < inlierTol)';%withdrew the sqrt at some point 
    if sum(inlierCheck) > max(best_inliers, inliersThreshold)
        best_inliers = sum(inlierCheck);
        inliers = indices(inlierCheck);
      %DEBUG
%         disp('=============================================');
%         disp(H_);
%         best_inliers
%         disp('=============================================');
        %UNKNOWN:why not save T = _H here ?...
        % T = H_;
  else
     H_;
    end
end
if isnan(inliers)
    disp('no model found for given tolerence');
    
else
    %Revaluate H using the inlier set 
    sampleInd = randsample(inliers, s);
    sourcePts = pos1(sampleInd, :); targetPts = pos2(sampleInd, :);
    T = getModel(sourcePts, targetPts);
end
end


