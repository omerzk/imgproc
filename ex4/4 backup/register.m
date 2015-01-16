function  T = register(images)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

T = cell(1, size(images, 3) - 1);
prevImages = images(:,:,:,1:end-1);
curImages = images(:,:,:,2:end);
filteredImages = zeros(size(images));

parfor z = 2:(size(images, 4))
    [prevPyr, ~] = GaussianPyramid(rgb2gray(prevImages(:,:,:,z-1)),15,5);
    [curPyr, ~] = GaussianPyramid(rgb2gray(curImages(:,:,:,z-1)),15,5);
    
    [curPos, curDesc] = findFeatures(curPyr, 800);
    [prevPos, prevDesc] = findFeatures(prevPyr, 800);
    
    [prevInd, curInd] = myMatchFeatures(prevDesc, curDesc, 0.7);
    
    [H , ~] = ransacTransform(prevPos(prevInd, :), curPos(curInd, :), 1000, 30);
    T{z-1} = H;
end


        
        
        
        

end

