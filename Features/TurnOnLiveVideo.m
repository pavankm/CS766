%=====================================================================
% Turn on the live video preview.  Display the bounding box over it if there is one selected.
function TurnOnLiveVideo(handles)
	global vidobj;	% Video camera object.
	% Bail out if there is no video object class instantiated.
	if isempty(vidobj), return, end;
	% Switch the current graphic axes to handles.axesImage.
	% This is where we want the video to go.
	axes(handles.axesImage);
	% Reset image magnification. Required if you ever displayed an image
	% in the axes that was not the same size as your webcam image.
	hold off;
	axis auto;  
	% Get the handle to the image in the axes.
	hImage = findobj(handles.axesImage, 'Type', 'image');
	% Turn on the live video.
	preview(vidobj, hImage);