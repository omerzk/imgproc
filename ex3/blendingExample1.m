function blendingExample1()
    im1 = im2double(imread('zh.jpg'));
    im2 = im2double(imread('lena.jpg'));
    %mask = imread(im2double('mask1.jpg'));
    mask = zeros(size(im1(:,:,1)));
    mask(100:230,50:190) = 1;
    size(mask)
    imBlendR = pyramidBlending(im1(:,:,1), im2(:,:,1), mask, 15, 3, 5);
    imBlendG = pyramidBlending(im1(2), im2(2), mask, 15, 3, 5);
    imBlendB = pyramidBlending(im1(3), im2(3), mask, 15, 3, 5);
    
    im(:,:,1) = imBlendR;im(:,:,2) = imBlendG;im(:,:,3) = imBlendB;
    imshow(im);
      
    
    
end