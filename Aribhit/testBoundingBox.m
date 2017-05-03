function result = testBoundingBox(fullFileName)

% clc;    % Clear the command window.
% close all;  % Close all figures (except those of imtool.)
% clear;  % Erase all existing variables. Or clearvars if you want.
% workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 14;

% Read in a color demo image.
% folder = pwd;
% baseFileName = 'Frame 0015.png';
% % Get the full filename, with path prepended.
% fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage=imread(fullFileName);
grayImage=255-grayImage;
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the original gray scale image.
%subplot(2, 2, 1);
%imshow(grayImage, []);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
%set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off'); 

binaryImage = grayImage < 128;
% Display the image.
subplot(1, 2, 1);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);

% Label the image
labeledImage = bwlabel(binaryImage);
measurements = regionprops(labeledImage, 'BoundingBox', 'Area');
for k = 1 : length(measurements)
  thisBB = measurements(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 );
end

% Let's extract the second biggest blob - that will be the hand.
allAreas = [measurements.Area];
[sortedAreas, sortingIndexes] = sort(allAreas, 'descend');
handIndex = sortingIndexes(1); % The hand is the second biggest, face is biggest.
% Use ismember() to extact the hand from the labeled image.
handImage = ismember(labeledImage, handIndex); 
% Now binarize
handImage = handImage > 0;
% Display the image.
subplot(1, 2, 2);
imshow(handImage, []);
title('Hand Image', 'FontSize', fontSize);

testRegions = regionprops(handImage, 'BoundingBox');
for k = 1 : length(testRegions)
  thisBB = testRegions(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 );
end

result = thisBB;

end