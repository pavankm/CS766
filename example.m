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

function [gabor_bank,gauss_bank] = initialize_gabor
%% Create Gabor Bank
l_exp = 1:4;
lambda = 2.*(2.^l_exp);
theta = 0:45:135;

gabor_bank = gabor(lambda,theta);

%% Create Gauss Bank
n_size = 128;
s = 8;
gauss_arr = cell(8,1);
for i = 1:8
    x_ax = 1:128;
    gauss_arr{i,1} = exp(-(x_ax - (16*i - 8)).^2/(2*s^2));
end

bank_im = zeros(n_size,n_size);
gauss_bank = cell(8,8);
for i = 1:8
    for j = 1:8
        gauss_bank{i,j} = gauss_arr{i,1}.' * gauss_arr{j,1};
        bank_im = bank_im + gauss_bank{i,j};
    end
end
end