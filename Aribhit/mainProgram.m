clear;

outFile = 'testVideo.avi';     %Could be input() as well
skinFile = 'skinVideo.avi';

%captureFromWebcam(outFile);
%extractBGSubFrames(outFile);
genSkinImages();
makeSkinVideo(skinFile);
compute();
BoundingBox();
DrawOriginalBox();


