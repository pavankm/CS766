function t = train_spm(rgb_img)

nrgb = get_normalized_rgb(rgb_img);

%{
virtual void train(const Mat& img_rgb, const Mat& mask) 
	{
		Mat nrgb = this->getNormalizedRGB(img_rgb);
		
		skin_hist.setTo(0); non_skin_hist.setTo(0);
		skin_hist = calc_rg_hist(nrgb,mask,hist_bins,low_range,high_range);
		non_skin_hist = calc_rg_hist(nrgb,~mask,hist_bins,low_range,high_range);
		
		//create a probabilty density function
		float skin_pixels = countNonZero(mask), non_skin_pixels = countNonZero(~mask);
		for (int ubin=0; ubin < hist_bins[0]; ubin++) {
			for (int vbin = 0; vbin < hist_bins[1]; vbin++) {
				if (skin_hist.at<float>(ubin,vbin) > 0) {
					skin_hist.at<float>(ubin,vbin) /= skin_pixels;
				}
				if (non_skin_hist.at<float>(ubin,vbin) > 0) {
					non_skin_hist.at<float>(ubin,vbin) /= non_skin_pixels;
				}
			}
		}
		
		if(this->verbose) this->visualizeHist(skin_hist,hist_bins,"skin hist");
		if(this->verbose) this->visualizeHist(non_skin_hist,hist_bins,"non skin hist");
		
		this->initialized = true;
	}
%}
end