function  T = register(images)
%register bundles all the image registration functions i wrote
%it takes a 4D vector(of size n) of images and outputs the set of n-1
%transformations between the it'h image to the i+1 image; 

T = cell(1, size(images, 3) - 1);
prevImages = images(:,:,:,1:end-1);
curImages = images(:,:,:,2:end);
%parallel computing which should reduce computation time by orders of
%magnitude in most desktop pc's.
parfor z = 2:(size(images, 4))
    [prevPyr, ~] = GaussianPyramid(rgb2gray(prevImages(:,:,:,z-1)),3,3);
    [curPyr, ~] = GaussianPyramid(rgb2gray(curImages(:,:,:,z-1)),3,3);
    
    [curPos, curDesc] = findFeatures(curPyr, 800);
    [prevPos, prevDesc] = findFeatures(prevPyr, 800);
    
    [prevInd, curInd] = myMatchFeatures(prevDesc, curDesc, 0.7);
    
    [H , ~] = ransacTransform(prevPos(prevInd, :), curPos(curInd, :), 700, 9);
    T{z-1} = H;
end



        
        
        
        

end

