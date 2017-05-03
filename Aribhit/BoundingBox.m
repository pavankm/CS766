function result = BoundingBox()

files = dir(['Skin/*.png']);

currFolder = pwd;
outputFolder = sprintf('%s/Rect', currFolder);

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

for i=1:50
    
    %img = imread(['Skin/',files(i).name]);
    
    %outputBaseFileName = sprintf('Frame %4.4d.png', i);
    %outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    
    %imwrite(skinImg, outputFullFileName, 'png');
    
    %outputBaseFileName = sprintf('Frame %4.4d.png', i);
    %outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    
    %imwrite(img, outputFullFileName, 'png');
    
    %box = regionprops(img,'BoundingBox');
    %imshow(img);
    
    recCoord = testBoundingBox(['Skin/',files(i).name]);
    %save(,recCoord);
    pause(0.05);
    %     for k = 1 : length(box)
    %         thisBB = box(k).BoundingBox;
    %         rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
    %                     'EdgeColor','r','LineWidth',2 )
    %     end
    
    outputBaseFileName = sprintf('coord%4.4d.mat', i);
    outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    
    save(outputFullFileName, 'recCoord');
end




end