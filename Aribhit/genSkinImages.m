function result = genSkinImages()

P = 100; %CHANGE MANUALLYBW2 = bwareaopen(BW,P)

files = dir(['Frames/*.png']);

currFolder = pwd;
outputFolder = sprintf('%s/Skin', currFolder);

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

for i =1:length(files)
    
    %img = imread(['Frames/',files(i).name]);
    
    skinImg = generate_skinmap(['Frames/',files(i).name]);
    skinImg = bwareaopen(skinImg,P);
    skinImg = 255.*uint8(skinImg);
    %imshow(skinImg);
    
    outputBaseFileName = sprintf('Frame %4.4d.png', i);
    outputFullFileName = fullfile(outputFolder, outputBaseFileName);
        
    imwrite(skinImg, outputFullFileName, 'png');
 
end

end