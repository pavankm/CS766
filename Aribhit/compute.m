function result = compute()

files1 = dir(['BGSub/*.png']);
files2 = dir(['Skin/*.png']);

currFolder = pwd;
outputFolder = sprintf('%s/Comb', currFolder);

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

for i =1:length(files1)
    
    img1 = imread(['BGSub/',files1(i).name]);
    img2 = imread(['Skin/',files2(i).name]);
    
    resImg = (img1 & img2);
    %resImg = (resImg + img2)
    
    outputBaseFileName = sprintf('Frame %4.4d.png', i);
    outputFullFileName = fullfile(outputFolder, outputBaseFileName);
        
    imwrite(resImg, outputFullFileName, 'png');
 
end


end
