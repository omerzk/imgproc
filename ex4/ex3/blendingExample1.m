function blendingExample1()
    %load images
    im1 = im2double(imread('cartb.jpg'));
    im2 = im2double(imread('ass.jpg'));
    mask = im2double(imread('mask.jpg'));
    %set paremeters
    filtersize = 3; maxlevels = 15; maskfiltersize = 111;
    
    res = rgbBlend(im1, im2, mask, maxlevels, filtersize, maskfiltersize); 
    figure('name', 'cartman','NumberTitle', 'off'); imshow(im1);
    figure('name', 'astronaut','NumberTitle', 'off'); imshow(im2);
    figure('name', 'mask','NumberTitle', 'off'); imshow(mask);
    figure('name', 'Astro-Cartman','NumberTitle', 'off'); imshow(res);
      
    
    
end