% |imageDatastore| recursively scans the directory tree containing the
% images. Folder names are automatically used as labels for each image.
ltrainingSet = imageDatastore(syntheticDir,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');
testSet     = imageDatastore(handwrittenDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');