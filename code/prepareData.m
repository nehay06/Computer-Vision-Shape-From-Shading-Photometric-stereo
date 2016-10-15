function output = prepareData(imArray, ambientImage)
% PREPAREDATA prepares the images for photometric stereo
%   OUTPUT = PREPAREDATA(IMARRAY, AMBIENTIMAGE)
%
%   Input:
%       IMARRAY - [h w n] image array
%       AMBIENTIMAGE - [h w] image 
%
%   Output:
%       OUTPUT - [h w n] image, suitably processed
%

% Step 1. Subtract the ambientImage from each image in imArray
% Step 2. Make sure no pixel is less than zero
% Step 3. Rescale the values in imarray to be between 0 and 1
[imageHeight,imageWidth,imageNum]= size(imArray);
output = zeros(imageHeight,imageWidth,imageNum);
for index = 1:imageNum
    output(:,:,index) = (imArray(:,:,index)-ambientImage);
    output(output<0) = 0;
  
   
end
 output = output./max(output(:));