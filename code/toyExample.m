function [ambientImage, imArray, lightDirs, ...
    trueAlbedo, trueSurfaceNormals, trueHeightMap] = toyExample(imageSize, numImages)

ambientImage = zeros(imageSize);
imArray = zeros([imageSize numImages]);
trueAlbedo = zeros(imageSize);

% Generate the scene
% Hemisphere radius is half the smaller dimension of the image
r = floor(min(imageSize)/2)-1;
ctr = ceil(imageSize/2);
cy = ctr(1);
cx = ctr(2);

% Lay down a meshgrid to compute the x and y coordinates
[xx, yy] = meshgrid(1:imageSize(2), 1:imageSize(1));
dd = r*r - (xx-cx).^2  - (yy-cy).^2;
bg = dd <= 0;
dd(bg) = 0;
trueHeightMap = sqrt(dd);

% Normals for the foreground are based on the point on the hemisphere
distance = sqrt((xx-cx).^2 + (yy-cy).^2 + trueHeightMap.^2);
nx = (xx-cx)./distance;
ny = (yy-cy)./distance;
nz = trueHeightMap./distance;
% Normals for the background are [0 0 1]
nx(bg) = 0;
ny(bg) = 0;
nz(bg) = 1;

trueSurfaceNormals = cat(3, nx, ny, nz);

% Albedo (chequered pattern)
trueAlbedo(1:cy,1:cx) = 1;
trueAlbedo(1:cy,cx+1:end) = 0.3;
trueAlbedo(cy+1:end,1:cx) = 0.3;
trueAlbedo(cy+1:end,cx+1:end) = 1;
trueAlbedo(bg) = 0.5;

% Generate random samples of light directions and images
lightDirs = randn(numImages, 3);
lightDirs(:,3) = abs(lightDirs(:,3)); %Only from above
l2norm = sqrt(sum(lightDirs.^2,2));
lightDirs = diag(1./l2norm)*lightDirs;
normalArray = reshape(trueSurfaceNormals, [prod(imageSize) 3]);
for i = 1:numImages,
    imArray(:,:,i) = reshape(trueAlbedo(:).*(normalArray*lightDirs(i,:)'), imageSize);
end

% Clip negative intensities (backface culling)
imArray = max(imArray, 0);