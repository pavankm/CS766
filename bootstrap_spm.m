function d = bootstrap_spm(rgb_img)
% converting to bgr - ref to the open cv demo
% http://www.morethantechnical.com/2013/03/05/skin-detection-with-probability-maps-and-elliptical-boundaries-opencv-wcode/
r = rgb_img(:,:,1);
g = rgb_img(:,:,2);
b = rgb_img(:,:,3);
rgb_img(:,:,1) = b;
rgb_img(:,:,2) = g;
rgb_img(:,:,3) = r;

hsv_img = rgb2hsv(img);


end