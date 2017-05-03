%function img_diff  = image_difference(video_obj, threshold)

video_data = read(video_obj);
number_of_frames = video_obj.NumberOfFrames;


for frame = 3:number_of_frames
    I_n = read(video_obj, frame);
    I_n_1 = read(video_obj, frame -1);
    I_n_2 = read(video_obj, frame -2);
    
    diff_1 = I_n - I_n_1;
    diff_2 = I_n - I_n_2;
    
    imshow(I_n);
end

%end