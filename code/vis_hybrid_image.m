function output = vis_hybrid_image(hybrid_image)
%visualize a hybrid image by progressively downsampling the image and
%concatenating all of the images together.

scales = 5; %how many downsampled versions to create
scale_factor = 0.5; %how much to downsample each time
padding = 5; %how many pixels to pad.

original_height = size(hybrid_image,1);
num_colors = size(hybrid_image,3); %counting how many color channels the input has
output = hybrid_image;
cur_image = hybrid_image;

for i = 2:scales
    %add padding
    output = cat(2, output, ones(original_height, padding, num_colors));
    
    %dowsample image;
    cur_image = imresize(cur_image, scale_factor, 'bilinear');
    %pad the top and append to the output
    tmp = cat(1,ones(original_height - size(cur_image,1), size(cur_image,2), num_colors), cur_image);
    output = cat(2, output, tmp);    
end


%code by James Hays