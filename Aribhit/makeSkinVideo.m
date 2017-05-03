function result = makeSkinVideo(outFile)

files = dir(['Skin/*.png']);

v = VideoWriter(outFile);

open(v);

for i=1:50
    
    img = imread(['Skin/',files(i).name]);
    
    %outputBaseFileName = sprintf('Frame %4.4d.png', i);
    %outputFullFileName = fullfile(outputFolder, outputBaseFileName);
        
    %imwrite(skinImg, outputFullFileName, 'png');
    
    %outputBaseFileName = sprintf('Frame %4.4d.png', i);
    %outputFullFileName = fullfile(outputFolder, outputBaseFileName);
            
    %imwrite(img, outputFullFileName, 'png');
    
    writeVideo(v,img);
end


close(v);


end
