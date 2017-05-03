function result = DrawOriginalBox()

files1 = dir(['Rect/*.mat']);
files2 = dir(['Frames/*.png']);

%currFolder = pwd;
%outputFolder = sprintf('%s/OrigBox', currFolder);
% 
% if ~exist(outputFolder, 'dir')
%     mkdir(outputFolder);
% end

for i=1:50
    
    img = imread(['Frames/',files2(i).name]);
    load(['Rect/',files1(i).name]);
    
    %outputBaseFileName = sprintf('Frame %4.4d.png', i);
    %outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    
    %imwrite(skinImg, outputFullFileName, 'png');
    
    %outputBaseFileName = sprintf('Frame %4.4d.png', i);
    %outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    
    %imwrite(img, outputFullFileName, 'png');
    
    %box = regionprops(img,'BoundingBox');
    imshow(img);
    rectangle('Position', [recCoord(1),recCoord(2),recCoord(3),recCoord(4)],...
                'EdgeColor','r','LineWidth',2 );
    %recCoord = testBoundingBox(['Skin/',files(i).name]);
    %save(,recCoord);
    pause(0.08);
    %     for k = 1 : length(box)
    %         thisBB = box(k).BoundingBox;
    %         rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
    %                     'EdgeColor','r','LineWidth',2 )
    %     end
    
%     outputBaseFileName = sprintf('coord%4.4d.mat', i);
%     outputFullFileName = fullfile(outputFolder, outputBaseFileName);
%     
%     save(outputFullFileName, 'recCoord');
end




end