function [cropped_mask,cropped_img] = pre_process(img)
    level = graythresh(img);
    binary_img = im2bw(img,level);
    binary_img  = imdilate(binary_img,strel('square',3));
    bmm_noholes = imfill(binary_img,'holes');
    x = bwareaopen(bmm_noholes,10000);
    x_bb = regionprops(x,'BoundingBox');
    cropped_mask = imcrop(x,x_bb.BoundingBox);
    cropped_img = imcrop(img,x_bb.BoundingBox);
end