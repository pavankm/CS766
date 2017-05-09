clc; clear all; close all;
x = 1;
letter = ['a','b','c','d','e','f','g','h','i','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y'];
features_complete = [];
[gabor_bank,gauss_bank] = initialize_gabor;
srcFiles = dir('MasseyDataset/*.png');
count = ones(1,24);
%% select images from dataset, segment out background and store them in a new folder
for j = 1:24                 
        for k= 1:size(srcFiles,1)
            
            str = cell2mat(strsplit(srcFiles(k).name));
            
            if str(7) == letter(j) && count(j) <= 10
                
                count(j) = count(j) + 1;
                filename = strcat('MasseyDataset/',srcFiles(k).name);
                X = imread(filename);           
               
                %%%%Morphological Preprocessing%%%%%
               [cropped_mask,cropped_img] = pre_process(X);
           
                 %%%%Extracting HOCD%%%%
                 features{x} = features_hocd(cropped_mask);

                 %%% update total features %%%
                 features_complete = [features_complete;features{x}];
                
                %%% assign class labels %%%
                Y(x,1) = j;
                x = x+1;
            end
         end
end
save('HOCDfeatures.mat', 'features_complete')


 %%% compute KNN Classifier Model and generalization error for this model %%%
 [trainedClassifier, gen_error] = trainKNNClassifier_hocd([features_complete,Y]);
  %%% compute SVM Classifier Model and generalization error for this model %%%
 %[trainedClassifier, gen_error] = trainSVMClassifier_hocd([features_complete,Y]);
 %%% compute RF Classifier Model and generalization error for this model %%%
 %[trainedClassifier, gen_error] = trainRFClassifier_hocd([features_complete,Y]);


save('KNN_hocd.mat', 'trainedClassifier')

srcFiles = dir('test/*.png');
x_test=1;
for j = 1:24                 
        for k= 1:size(srcFiles,1)
            str = cell2mat(strsplit(srcFiles(k).name)
            if str(7) == letter(j) && count(j) <= 10
                count(j) = count(j) + 1;
                filename = strcat('test/',srcFiles(k).name);
                X = imread(filename);  
                [cropped_mask,cropped_img] = pre_process(X);          
                features_test = features_hocd(cropped_mask);
                 %uncomment for KNN
                 predictions(x_test,1) = trainedClassifier.predictFcn(features_test);
               %uncomment for svm
               %predictions(x_test,1) = predict(trainedClassifier,features_test);
                %uncomment for RF
                % predictions(x_test,1) = trainedClassifier.predict(features_test);
                 
               label_test(x_test,1) = j;
                x_test=x_test+1;
               end       
        end
end

test_error = 1 - (size(find(predictions==label_test),1)/size(predictions,1))