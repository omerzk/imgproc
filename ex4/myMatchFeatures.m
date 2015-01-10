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
ind1 = zeros(size(desc1, 3),1);
ind2 = zeros(size(desc1, 3),1);
matched = zeros(size(desc2, 3),1);
found = 0;

spread = reshape(desc2,[49 size(desc2,3)]);

for k=1 : size(desc1, 3)
    prod = reshape(desc1(: , :, k),[49 1])' * spread;
    [x, m] = max(prod);
%     y =max(prod(prod < x));%part of the ratio test
    if x > minScore && ~matched(m,1)
        if 1% x*0.70 > y%ratio test reconsider
        found = found + 1;
        ind2(found, 1) = m; ind1(found, 1) = k;
        matched(m, 1) = true;
        end
    end
end
ind1 = ind1(1:found, 1);ind2 = ind2(1:found, 1);
end