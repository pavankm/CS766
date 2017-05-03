function result = captureFromWebcam(outFile)

cameraList = webcamlist;
cam = webcam(cameraList{1});
v = VideoWriter(outFile);

open(v);

for i=1:50
    img = snapshot(cam);
    
    writeVideo(v,img);
end

close(v);
clear('cam');

v = VideoReader(outFile);

currFolder = pwd;
outputFolder = sprintf('%s/Frames', currFolder);

if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

for i=1:50
   outputBaseFileName = sprintf('Frame %4.4d.png', i);
   outputFullFileName = fullfile(outputFolder, outputBaseFileName);
   
   frame = read(v, i);
   imwrite(frame, outputFullFileName, 'png');
    
end

%close(v);
result = outFile;

end
