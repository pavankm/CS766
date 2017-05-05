%NEW TEST
letter = ['a','b','c','d','e','f','g','h','i','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y'];
load('KNN.mat');
[gabor_bank,gauss_bank] = initialize_gabor;
filename= 'test_image.png'
subplot(1,2,1),imshow(filename)
drawnow;
X = imread(filename);  
[cropped_mask,cropped_img] = pre_process(X);
features_test = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];
prediction=trainedClassifier.predictFcn(features_test);
 subplot(1,2,2),imshow(strcat('alphabet/',letter(prediction),'.jpg'))
 drawnow;

              
      

