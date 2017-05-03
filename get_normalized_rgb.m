function nrgb  = get_normalized_rgb(img)

%% normalize RGB
num_rows=size(img,1);
num_cols=size(img,2);
nrgb=zeros(num_rows,num_cols,3);

nrgb = zeros(size(img));
sum_rgb = double(img(:,:,1)) + double(img(:,:,2)) + double(img(:,:,3));

nrgb(:,:,1) = zeros(size(sum_rgb)); % rdivide(double(img(:,:,1)), sum_rgb);
nrgb(:,:,2) = rdivide(double(img(:,:,2)), sum_rgb);
nrgb(:,:,3) = rdivide(double(img(:,:,3)), sum_rgb);


end