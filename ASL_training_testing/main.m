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
           
%                 %%%%Extracting only HOCD%%%%
          features{x} = features_hocd(cropped_mask);
%                 
%                 %%%%Extracting only Gabor%%%%
          % features{x} = features_gabor(cropped_img,gabor_bank,gauss_bank);
%                 
                %%%Extracting HOCD+Gabor%%%%
%               features{x} = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];
                       
                %%%Extracting SURF Points%%%%
%                  points = detectSURFFeatures(rgb2gray(cropped_img));
%               [features{x},valid_points]  = extractFeatures(rgb2gray(cropped_img),points);
%                 
                
                %%% update total features %%%
                features_complete = [features_complete;features{x}];
                
                %%% assign class labels %%%
                Y(x,1) = j;
                x = x+1;
            end
         end
end
save('features.mat', 'features_complete')
% 
% 
% % 
% % uncomment if using surf bag of words features
% 
% k = 200;
% [~,C] = kmeans(features_complete,k);
% 
% %% compute histograms for each image by assigning feature descriptors in image to nearest cluster centroid
% hist = zeros(x-1,k);
% dist = [];
% for i = 1:x-1
%     for j = 1:size(features{i},1)
%         for l = 1:size(C,1)
%             dist(l) = sqrt(sum((features{i}(j,:)-C(l,:)).^2,2));
%         end
%         [~,idx] = min(dist);
%         hist(i,idx) = hist(i,idx) + 1;
%     end
% end
% 
% 
% for i = 1:x-1
%     hist(i,:) = hist(i,:)/norm(hist(i,:),2);
% end

% 
% 
% 
% 
% 
% %%% compute KNN Classifier Model and generalization error for this model %%%
% 
% %%%uncomment if using only hocd features, keep other two commented
% [trainedClassifier, gen_error] = trainKNNClassifier_hocd([features_complete,Y]);

%%%uncomment if using only gabor features, keep other two commented
%[trainedClassifier, gen_error] = trainRFClassifier_gabor([features_complete,Y]);

%%%uncomment if using only hocd and gabor features, keep other two commented
 [trainedClassifier, gen_error] = trainKNNClassifier_hocd_plus_gabor([features_complete,Y]);

%%%uncomment if using only SURF Bag of Words features, keep other two commented
%[trainedClassifier, gen_error] = trainKNNClassifier_SURFBoW([hist,Y]);

%% uncomment for svm
%[trainedClassifier, gen_error] = trainSVMClassifier_hocd([features_complete,Y]);

save('KNN_hocd.mat', 'trainedClassifier')
% 
%% Testing the classifier on 10 actual images
% predictions= zeros(10,1)
% load('test_images.mat');
% label_test = [1;2;3;4;7;9;11;15;22;24];
% x_test = 1;
% for i = 1:10
%     img_test{i} = img{i};
%     
%     %%%%Morphological Preprocessing%%%%%
%     [cropped_mask,cropped_img] = pre_process(img_test{i});
%            
%    %%%%Extracting only HOCD%%%%
%  % features_test = features_hocd(cropped_mask);
%    
% %                 
% %   %%%%Extracting only Gabor%%%%
%  features_test = features_gabor(cropped_img,gabor_bank,gauss_bank);
% %                 
%     %%%Extracting HOCD+Gabor%%%%
%   %  features_test = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];
%                         
%     
%    predictions(i,1) = trainedClassifier.predictFcn(features_test);
%    %uncomment for svm
%    %predictions(i,1) = predict(trainedClassifier,features_test);
%    
%     x_test = x_test+1;
% end
% %save('p.mat', 'predictions');
% predictions
% %predictions= cell2mat(predictions);
% % label_test=A;
% % index = cellfun(@strcmp, predictions, label_test);
% % 
% % int = cell(1, length(predictions));
% % int(index) = predictions(index);
% % int =cell2mat(int)
% test_error = 1 - (size(find(predictions==label_test),1)/size(predictions,1))


% %NEW TEST
% %srcFiles = dir('test/*.png');
% srcFiles = dir('final_test/*.jpg');
% cam = webcam('FaceTime HD Camera')
% preview(cam)
% pause()
% img = snapshot(cam);
% imshow(img);
% closePreview(cam)
% clear('cam');
% %srcFiles = dir('MasseyDataset/*.png');
% count = ones(1,24);
% predictions=zeros(26,1);
% label_test=zeros(26,1);
% x_test = 1;
% %% select images from dataset, segment out background and store them in a new folder
%                 
%  for k= 1:size(srcFiles,1)
%             
%             str = cell2mat(strsplit(srcFiles(k).name));
%           
%             %if str(1) == letter{j} && count(j) <= 100
%                 
%                 count(j) = count(j) + 1;
%                 filename = strcat('final_test/',srcFiles(k).name);
%                
%                 subplot(1,2,1),imshow(filename)
%                 drawnow;
%                 X = imread(filename);  
%                 [cropped_mask,cropped_img] = pre_process(X);
%                 
%                              %%%%Extracting only HOCD%%%%
%              % features_test = features_hocd(cropped_mask);
% 
%             %                 
%             %   %%%%Extracting only Gabor%%%%
%            %  features_test = features_gabor(cropped_img,gabor_bank,gauss_bank);
%             %                 
%                 %%%Extracting HOCD+Gabor%%%%
%                features_test = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];
% 
%                 
%                
%                 [label,score,cost]= predict(trainedClassifier.ClassificationKNN, features_test);
%                 [sortedValues,sortIndex] = sort(score(:),'descend');  %# Sort the values in
%                                                   %#   descending order
%                 maxIndex = sortIndex(1:3);
%                 fprintf('KNN label  %s  \t ', letter(label));
%                 
%                 for u=1:size(maxIndex)
%                     fprintf('%s %d \t', letter(maxIndex(u)), score(maxIndex(u)));
%                 end
%                 predictions(x_test, 1)=trainedClassifier.predictFcn(features_test);
%                 fprintf('actual label is %s\n', str(1));
%                 
%                 
%                 subplot(1,2,2),imshow(strcat('alphabet/',str(1),'.jpg'))
%                 
%                 drawnow;
%                 clf;
%                %uncomment for svm
%                %predictions(x_test,1) = predict(trainedClassifier,features_test);
%                 label_test(x_test,1) = find(letter == str(1)); 
%                 %uncomment for RF
%                 % predictions(x_test,1) = trainedClassifier.predict(features_test);
%                 x_test = x_test+1;
%                 
%             %end
%  end
% 
% test_error = 1 - (size(find(predictions==label_test),1)/size(predictions,1))
% 
% %A= cellfun(@str2double,predictions)
% 
% %test_error = 1 - (size(find(A==label_test),1)/size(A,1))
% 
% 
% 
% 
% 
% % X = imread('hand.jpg');  
% % [cropped_mask,cropped_img] = pre_process(X);
% % features_test = [features_gabor(cropped_img,gabor_bank,gauss_bank),features_hocd(cropped_mask)];
% % predictions= trainedClassifier.predictFcn(features_test)



srcFiles = dir('test/*.png');
x_test=1;
for j = 1:24                 
        for k= 1:size(srcFiles,1)
            
            str = cell2mat(strsplit(srcFiles(k).name))
           
            if str(7) == letter(j) && count(j) <= 100
                
                count(j) = count(j) + 1;
                filename = strcat('test/',srcFiles(k).name);


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


                predictions(x_test,1) = trainedClassifier.predictFcn(features_test);
               %uncomment for svm
               %predictions(x_test,1) = predict(trainedClassifier,features_test);
               %label_test(x_test,1) = find(letter ==char(testDigitData.Labels(j)));
                 label_test(x_test,1) = j;
                x_test=x_test+1;
                %uncomment for RF
                % predictions(x_test,1) = trainedClassifier.predict(features_test);
            end       
        end
end

test_error = 1 - (size(find(predictions==label_test),1)/size(predictions,1))