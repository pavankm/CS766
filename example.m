%img = rgb2gray(imread('/home/pavan/ASL_training_testing/MasseyDataset/hand1_f_dif_seg_3_cropped.png'));
%binary_img = imbinarize(img);
%perimeter = regionprops(binary_img,'Perimeter');

I = double(imread('/home/pavan/ASL_training_testing/MasseyDataset/hand1_f_dif_seg_3_cropped.png'));
%I = double(imread('/home/pavan/Pictures/madiso state street.jpg'));
X = reshape(I,size(I,1)*size(I,2),3); % size(X) = number of pixels * 3[RGB]
coeff = pca(X);
Itransformed = X*coeff;
Ipc1 = reshape(Itransformed(:,1),size(I,1),size(I,2));
Ipc2 = reshape(Itransformed(:,2),size(I,1),size(I,2));
Ipc3 = reshape(Itransformed(:,3),size(I,1),size(I,2));
figure, imshow(Ipc1,[]);
figure, imshow(Ipc2,[]);
figure, imshow(Ipc3,[]);

function [result,centroid] = findEdgeMapCentroid(img)
    
    a = regionprops(img,'Centroid');
    centroid = a.Centroid;
   %figure; imshow(img); hold on; plot(centroid(1),centroid(2),'x');
    img_dilated = imdilate(img,strel('square',3));
    img_eroded = imerode(img,strel('square',3));
    result = img_dilated-img_eroded;
end