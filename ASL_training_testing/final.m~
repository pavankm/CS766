%NEW TEST

srcFiles = dir('final_test/*.jpg');

count = ones(1,24);
predictions=zeros(26,1);
label_test=zeros(26,1);
x_test = 1;
%% select images from dataset, segment out background and store them in a new folder
                
 for k= 1:size(srcFiles,1)
            
            str = cell2mat(strsplit(srcFiles(k).name));
          
           
                
                count(j) = count(j) + 1;
                filename = strcat('final_test/',srcFiles(k).name);
               
                subplot(1,2,1),imshow(filename)
                drawnow;
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
                
                
                subplot(1,2,2),imshow(strcat('alphabet/',str(1),'.jpg'))
                
                drawnow;
                clf;
               %uncomment for svm
               %predictions(x_test,1) = predict(trainedClassifier,features_test);
                label_test(x_test,1) = find(letter == str(1)); 
                %uncomment for RF
                % predictions(x_test,1) = trainedClassifier.predict(features_test);
                x_test = x_test+1;
                
           
 end
