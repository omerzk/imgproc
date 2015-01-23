function  T = register(images)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
maxPoints = 800; nIter = 700; minMatch = 0.7; inlierTol = 9;
T = cell(1, size(images, 3) - 1);
%scrifice some space inorder to allow for more efficient parllel computing
prevImages = images(:,:,:,1:end-1);
curImages = images(:,:,:,2:end);
%parellel processing of the most costly part of the program 
%to make this part parallelizable i actually made it less efficent 
%meaning i dont use the resualts of previous computations 
% yet the reward in run time is sufficent.
parfor z = 2:(size(images, 4))
    [prevPyr, ~] = GaussianPyramid(rgb2gray(prevImages(:,:,:,z-1)),15,5);
    [curPyr, ~] = GaussianPyramid(rgb2gray(curImages(:,:,:,z-1)),15,5);
    
    [curPos, curDesc] = findFeatures(curPyr, maxPoints);
    [prevPos, prevDesc] = findFeatures(prevPyr, maxPoints);
    
    [prevInd, curInd] = myMatchFeatures(prevDesc, curDesc, minMatch);
    
    [H , ~] = ransacTransform(prevPos(prevInd, :), curPos(curInd, :), nIter, inlierTol);
    T{z-1} = H;
end


        
        
        
        

end

