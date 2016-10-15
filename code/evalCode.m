
% Evaluation code for photometric stereo
% 
% Your goal is to implement the three functions prepareData(), 
% photometricStereo() and getSurface() to estimate the albedo and shape of
% the objects in the scene from multiple images. 
%
% Start with setting subjectName='debug' which sets up a toy scene with
% known albedo and height which you can compare against. After you have a
% good implementation of this part, set the subjectName='yabeB01', etc. to
% run your code against real images of people. 
%

clc;
clear;

dataDir     = fullfile('..','data'); % Path to your data directory
subjectName = 'yaleB02'; %debug, yaleB01, yaleB02, yaleB05, yaleB07
numImages   = 128; % Total images for each surface
debug       = true; % Set the debug flag to true to check your implementation first
writeOutput = true; % If true then the output will be written to output 
outputDir   = fullfile('..','output');
imageDir    = fullfile(dataDir, subjectName);
integrationMethod = 'random';

%% Load images for different viewing conditions
if strcmp(subjectName, 'debug'),
    imageSize = [64 64];
    [ambientImage, imArray, lightDirs, trueAlbedo, trueSurfaceNormals, trueHeightMap] = toyExample(imageSize, numImages);
else
    [ambientImage, imArray, lightDirs] = loadFaceImages(imageDir, subjectName, numImages);
end

%% Prepare the data for algorithm
imArray = prepareData(imArray, ambientImage);

%% Decompose the scene into shape and albedo
[albedoImage, surfaceNormals] = photometricStereo(imArray, lightDirs);

%imagesc(albedoImage); axis image off ; colormap gray;
%% Compute height from normals by integration along paths
heightMap = getSurface(surfaceNormals, integrationMethod);

%% Display the output
[hfigure] = displayOutput(albedoImage, heightMap);
plotSurfaceNormals(surfaceNormals);

%% Hint: If debugging you can compare your results to this %%%
if strcmp(subjectName, 'debug'), 
    displayOutput(trueAlbedo, trueHeightMap);
    plotSurfaceNormals(trueSurfaceNormals);
end

%% Optionally write the output
if writeOutput,
    if ~exist(outputDir, 'file')
        mkdir(outputDir);
    end
    % Write out the albedo image
    imageName = fullfile(outputDir, sprintf('%s_albedo.jpg', subjectName));
    imwrite(albedoImage, imageName, 'jpg');
    
    % Write out the normals as a color image
    imageName = fullfile(outputDir, sprintf('%s_normals_color.jpg', subjectName));
    imwrite(surfaceNormals, imageName, 'jpg');
    
    % Write out the normals as seperate (x, y, z) components
    imageName = fullfile(outputDir, sprintf('%s_normals_x.jpg', subjectName));
    imwrite(surfaceNormals(:,:,1), imageName, 'jpg');
    
    imageName = fullfile(outputDir, sprintf('%s_normals_y.jpg', subjectName));
    imwrite(surfaceNormals(:,:,2), imageName, 'jpg');

    imageName = fullfile(outputDir, sprintf('%s_normals_z.jpg', subjectName));
    imwrite(surfaceNormals(:,:,3), imageName, 'jpg');
    
    imageName = fullfile(outputDir, sprintf('%s_normals_z.jpg', subjectName));
    imwrite(surfaceNormals(:,:,3), imageName, 'jpg');
    
    imageName = strcat(subjectName,'SavedHeightMap.jpg') ;
    saveas(hfigure,fullfile(outputDir, imageName))
end
