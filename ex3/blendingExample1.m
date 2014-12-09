function blendingExample1()
    im1 = im2double(imread('zh.jpg'));
    im2 = im2double(imread('lena.jpg'));
    filtersize = 3; maxlevels = 15; maskfiltersize =3;
    %mask = imread(im2double('mask1.jpg'));
    mask = zeros(size(im1(:,:,1)));
    mask(60:230,60:180) = 1;
    res = rgbBlend(im1, im2, mask, maxlevels, filtersize, maskfiltersize);
    imshow(res);
      
    
    
end