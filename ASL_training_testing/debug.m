%NEW TEST
%srcFiles = dir('test/*.png');
srcFiles = dir('test_ds_2_orig/*.jpg');
%srcFiles = dir('MasseyDataset/*.png');
count = ones(1,24);
predictions=zeros(26,1)
label_test=zeros(26,1)
x_test = 1;
%% select images from dataset, segment out background and store them in a new folder
                
 for k= 1:size(srcFiles,1)
            
            str = cell2mat(strsplit(srcFiles(k).name));
          
            %if str(1) == letter{j} && count(j) <= 100
                
                count(j) = count(j) + 1;
                filename = strcat('test_ds_2_orig/',srcFiles(k).name);
                filename= 'test_ds_2_orig/d.jpg';
                X = imread(filename);  
                [cropped_mask,cropped_img] = pre_process(X);
                
                             %%%%Extracting only HOCD%%%%
             % features_test = features_hocd(cropped_mask);

            %                 
            %   %%%%Extracting only Gabor%%%%
           %  features_test = features_gabor(cropped_img,gabor_bank,gauss_bank);
            %                 
                %%%Extracting HOCD+Gabor%%%%
               features_test = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];

                
               
                [label,score,cost]= predict(trainedClassifier.ClassificationKNN, features_test);
                [sortedValues,sortIndex] = sort(score(:),'descend');  %# Sort the values in
                                                  %#   descending order
                maxIndex = sortIndex(1:3);
                fprintf('KNN label  %s  \t ', letter(label));
                
                for u=1:size(maxIndex)
                    fprintf('%s %d \t', letter(maxIndex(u)), score(maxIndex(u)));
                end
                predictions(x_test, 1)=trainedClassifier.predictFcn(features_test);
                fprintf('actual label is %s\n', str(1));
                
               %uncomment for svm
               %predictions(x_test,1) = predict(trainedClassifier,features_test);
                label_test(x_test,1) = find(letter == str(1)); 
                %uncomment for RF
                % predictions(x_test,1) = trainedClassifier.predict(features_test);
                x_test = x_test+1;
            %end
 end
predictions
label_test
test_error = 1 - (size(find(predictions==label_test),1)/size(predictions,1))

%A= cellfun(@str2double,predictions)

%test_error = 1 - (size(find(A==label_test),1)/size(A,1))





% X = imread('hand.jpg');  
% [cropped_mask,cropped_img] = pre_process(X);
% features_test = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];
% predictions= trainedClassifier.predictFcn(features_test)
