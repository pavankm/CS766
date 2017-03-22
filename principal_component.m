function coeff = principal_component(img)
    %{
        Principal components of a binary image
        Returns: 2x2 matrix
    %}
    [rows, cols] = find(bwperim(img));
    coeff = pca([rows cols]);
end