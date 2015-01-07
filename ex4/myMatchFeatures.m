function [ind1,ind2] = myMatchFeatures(desc1,desc2,minScore)
% MYMATCHFEATURES Match feature descriptors in desc1 and desc2.
% Arguments:
% desc1 ? A kxkxn1 feature descriptor matrix.
% desc2 ? A kxkxn2 feature descriptor matrix.
% minScore ? Minimal match score between two descriptors required to be
% regarded as matching.
% Returns:
% ind1,ind2 ? These are m?entry arrays of match indices in desc1 and desc2. %
% Note:
% 1. The descriptors of the ith match are desc1(ind1(i)) and desc2(ind2(i)).
% 2. The number of feature descriptors n1 generally differs from n2
% 3. ind1 and ind2 have the same length.

end
