function [albedoImage, surfaceNormals] = photometricStereo(imArray, lightDirs)
% PHOTOMETRICSTEREO compute intrinsic image decomposition from images
%   [ALBEDOIMAGE, SURFACENORMALS] = PHOTOMETRICSTEREO(IMARRAY, LIGHTDIRS)
%   comptutes the ALBEDOIMAGE and SURFACENORMALS from an array of images
%   with their lighting directions. The surface is assumed to be perfectly
%   lambertian so that the measured intensity is proportional to the albedo
%   times the dot product between the surface normal and lighting
%   direction. The lights are assumed to be of unit intensity.
%
%   Input:
%       IMARRAY - [h w n] array of images, i.e., n images of size [h w]
%       LIGHTDIRS - [n 3] array of unit normals for the light directions
%
%   Output:
%        ALBEDOIMAGE - [h w] image specifying albedos
%        SURFACENORMALS - [h w 3] array of unit normals for each pixel


[imageHeight,imageWidth,imageNum] = size(imArray);
colneImarray = zeros(imageNum,imageWidth*imageHeight);

for imageNum = 1:imageNum
    colneImarray(imageNum,:) = reshape(imArray(:,:,imageNum),1,[]);
end

g =lightDirs\colneImarray;

tst = zeros(1,imageHeight*imageWidth);
normal = zeros(3,imageHeight*imageWidth);
for j=1:imageHeight*imageWidth
    tst(1,j) = norm(g(:,j));
    normal(:,j) = g(:,j)./norm(g(:,j));
end


albedoImage = reshape(tst,imageHeight,imageWidth);
surfaceNormals = cat(3,reshape(normal(1,:),imageHeight,imageWidth),reshape(normal(2,:),imageHeight,imageWidth),reshape(normal(3,:),imageHeight,imageWidth));

