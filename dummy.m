img=imread('/home/pavan/comp_vis_ds/a.png');
% converting to bgr - ref to the open cv demo
% http://www.morethantechnical.com/2013/03/05/skin-detection-with-probability-maps-and-elliptical-boundaries-opencv-wcode/
r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);
img(:,:,1)=b;
img(:,:,2)=g;
img(:,:,3)=r;

hsv = rgb2hsv(img);
h=hsv(:,:,1);
h=h>=0 & h<=(50.0/2.0);
s=hsv(:,:,2);
s=s>=(0.2) & s<=(0.68);
v=hsv(:,:,3);
v=v>=(0.35) & v<=(1.0);


hsv=h&s&v;
hsv=hsv*255;
imshow(hsv*255);

%%  inRange implementation
im = rgb2hsv(img);
minval = [0, 0.2, 0.35]; %// Define three element vector here for each colour plane i.e. [0 128 128];
maxval = [50.0 / 2, 0.68, 1.0]; %// Define three element vector here for each colour plane i.e. [0 128 128];

out = true(size(im,1), size(im,2));
for p = 1 : 3
    out = out & (im(:,:,p) >= minval(p) & im(:,:,p) <= maxval(p));
end

%% normalize RGB
num_rows=size(img,1);
num_cols=size(img,2);
nrgb=zeros(num_rows,num_cols,3);
for row=1:num_rows
    for col=1:num_cols
        total=double(img(row,col,1))+double(img(row,col,2))+double(img(row,col,3));
        nrgb(row,col,1)=double(img(row,col,1))/total;
        nrgb(row,col,2)=double(img(row,col,2))/total;
        nrgb(row,col,3)=double(img(row,col,3))/total;
    end
end
%-------------------------------------------------

%% in range
im = img;
minval = [0.36*255, 0.28*255, 0]; %// Define three element vector here for each colour plane i.e. [0 128 128];
maxval = [0.465*255, 0.363*255, 1.0*255]; %// Define three element vector here for each colour plane i.e. [0 128 128];

out_2 = true(size(im,1), size(im,2));
for p = 1 : 3
    out_2 = out_2 & (im(:,:,p) >= minval(p) & im(:,:,p) <= maxval(p));
end

%%
b=nrgb(:,:,1);
b=(b>=0.0 & b<=(1));
g=nrgb(:,:,2);
g=(g>=(0.28) & g<=(0.363));
r=nrgb(:,:,3);
r=(r>=(0.36) & r<=(0.465));
rgb=r&g&b;
rgb=rgb*255;
%-------------------------------------------------------------
%imshow(rgb)


outputmask=hsv&rgb;
%imshow(double(outputmask));



%{
Mat nrgb = getNormalizedRGB(img_rgb);
 
MatND skin_hist,non_skin_hist;
skin_hist = calc_rg_hist(nrgb,mask);
non_skin_hist = calc_rg_hist(nrgb,~mask);
         
//create a probabilty density function
float skin_pixels = countNonZero(mask), non_skin_pixels = countNonZero(~mask);
for (int ubin=0; ubin < 250; ubin++) {
    for (int vbin = 0; vbin < 250; vbin++) {
        if (skin_hist.at<float>(ubin,vbin) > 0) {
            skin_hist.at<float>(ubin,vbin) /= skin_pixels;
        }
        if (non_skin_hist.at<float>(ubin,vbin) > 0) {
            non_skin_hist.at<float>(ubin,vbin) /= non_skin_pixels;
        }
    }
}


%}