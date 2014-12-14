function blendingExample2()
    %load images
    im1 = im2double(imread('tiger.1.jpg'));
    im2 = im2double(imread('bun.jpg'));
    mask = im2double(imread('mask3.3.2.2.jpg'));
    %set paremeters
    filtersize = 3; maxlevels = 10; maskfiltersize = 91;
    
    res = rgbBlend(im1, im2, mask, 5, filtersize, maskfiltersize);
    figure('name', 'Tiger','NumberTitle', 'off'); imshow(im1);
    figure('name', 'Bunny','NumberTitle', 'off'); imshow(im2);
    figure('name', 'mask','NumberTitle', 'off'); imshow(mask);
    figure('name', 'Tiger-bunny','NumberTitle', 'off'); imshow(res);

end

