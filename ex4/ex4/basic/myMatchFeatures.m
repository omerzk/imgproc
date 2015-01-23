function [ind1,ind2] = myMatchFeatures(desc1,desc2,minScore)
% MYMATCHFEATURES Match feature descriptors in desc1 and desc2.
% Arguments:
% desc1 ??? A kxkxn1 feature descriptor matrix.
% desc2 ??? A kxkxn2 feature descriptor matrix.
% minScore ??? Minimal match score between two descriptors required to be
% regarded as matching.
% Returns:
% ind1,ind2 ??? These are m???entry arrays of match indices in desc1 and desc2.
%
% Note:
% 1. The descriptors of the ith match are desc1(ind1(i)) and desc2(ind2(i)).
% 2. The number of feature descriptors n1 generally differs from n2
% 3. ind1 and ind2 have the same length.
%init

ind1 = zeros(size(desc1, 3),1);
ind2 = zeros(size(desc1, 3),1);
matched = zeros(size(desc2, 3),1);
found = 0;
%spread the desc2 matrices into a 49xn matrix where every
spread = reshape(desc2, [49 size(desc2,3)]);

for k=1 : size(desc1, 3)
    %dot product of the k'th dexcriptor from 1 with all from 2
    prod = reshape(desc1(: , :, k),[49 1])' * spread;
    %maximal match
    [x, m] = max(prod);
    
    if x > minScore && ~matched(m,1)
        found = found + 1;
        ind2(found, 1) = m; ind1(found, 1) = k;
        matched(m, 1) = true;
    end
end
%trim
ind1 = ind1(1:found, 1);ind2 = ind2(1:found, 1);
end