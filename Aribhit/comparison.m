function result = comparison()

files1 = dir(['Frames/*.png']);
files2 = dir(['Skin/*.png']);

figure;

for j = 1:10
    imshow(['Frames/',files1(1).name])
end

%implay('testVideo.avi')
%implay('skinVideo.avi')
for i =1:length(files1)
    
    %figure;
    
    img1 = imread(['Frames/',files1(i).name]);
    img2 = imread(['Skin/',files2(i).name]);
    
    subplot(1,2,1);
    imshow(img1);
    drawnow;
    
    subplot(1,2,2);
    imshow(img2);
    drawnow;
   
    
    %resImg = (img1 & img2);
    %resImg = (resImg + img2)
    
    %outputBaseFileName = sprintf('Frame %4.4d.png', i);
    %outputFullFileName = fullfile(outputFolder, outputBaseFileName);
        
    %imwrite(resImg, outputFullFileName, 'png');
 
end



end