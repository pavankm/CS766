function hist = hocd(img)

    % todo: move this to a common place?
    [cropped_mask,~] = crop_image(img);
    edge_map = bwperim(cropped_mask);
    a = regionprops(img,'Centroid');
    centroid = a.Centroid;
    
    distances = distance_edge_to_centroid(edge_map,centroid);
    
    num_bins = 50; % todo: tune this
    hist = histogram(distances, num_bins);
    hist = hist.Values/norm(distances);
end