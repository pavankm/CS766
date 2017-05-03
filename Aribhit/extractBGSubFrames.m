function extractBGSubFrames(movieFullFileName)

try
    videoObject = VideoReader(movieFullFileName);
    
    numberOfFrames = videoObject.NumberOfFrames;    % Determine how many frames there are.
    numWritten = 0;
    
    % Extract out the various parts of the filename.
    [currFolder, baseFileName, extentions] = fileparts(movieFullFileName);
    
    % Make up a special new output subfolder for all the separate
    % movie frames that we're going to extract and save to disk.
    
    currFolder = pwd;   % Make it a subfolder of the folder where this m-file lives.
    outputFolder1 = sprintf('%s/AdaptiveBG', currFolder);
    outputFolder2 = sprintf('%s/BGSub', currFolder);
    
    % Create the folder if it doesn't exist already.
    if ~exist(outputFolder1, 'dir')
        mkdir(outputFolder1);
    end
    
    if ~exist(outputFolder2, 'dir')
        mkdir(outputFolder2);
    end
    
    % Loop through the movie, writing all frames out.
    % Each frame will be in a separate file with unique name.
    
    for frame = 1 : numberOfFrames
        % Extract the frame from the movie structure.
        thisFrame = read(videoObject, frame);
        
        % Now let's do the differencing
        alpha = 0.5;
        if frame == 1
            Background = thisFrame;
        else
            % Change background slightly at each frame
            % 			Background(t+1)=(1-alpha)*I+alpha*Background
            Background = (1-alpha)* thisFrame + alpha * Background;
        end
        
        outputBaseFileName = sprintf('Frame %4.4d.png', frame);
        outputFullFileName = fullfile(outputFolder1, outputBaseFileName);
        
        imwrite(Background, outputFullFileName, 'png');
        
        % Calculate a difference between this frame and the background.
        differenceImage = thisFrame - uint8(Background);
        % Threshold with Otsu method.
        grayImage = rgb2gray(differenceImage); % Convert to gray level
        thresholdLevel = graythresh(grayImage); % Get threshold.
        binaryImage = im2bw( grayImage, thresholdLevel); % Do the binarization
        % Plot the binary image.
        %subplot(2, 2, 4);
        %imshow(binaryImage);
        %title('Binarized Difference Image', 'FontSize', fontSize);
        
        outputBaseFileName = sprintf('Frame %4.4d.png', frame);
        outputFullFileName = fullfile(outputFolder2, outputBaseFileName);
        
        imwrite(binaryImage, outputFullFileName, 'png');
        
        numWritten = numWritten + 1;
    end
    
    % Alert user that we're done.
    
    disp(['Wrote ',num2str(numWritten),' frames']); % Write to command window.
    
    %close(videoObject);
    % Get rid of old image and plot.
    
catch ME
    % Some error happened if you get here.
    disp(ME);
    disp('Error finding background subtraction from file');
end

