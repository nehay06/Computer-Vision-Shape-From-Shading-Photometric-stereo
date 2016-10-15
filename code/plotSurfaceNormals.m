function plotSurfaceNormals(surfaceNormals)
% PLOTSURFACENORMALS(SURFACENORMALS) displays the surface normals
%
% Input:
%   SURFACENORMALS - [h w 3] matrix of unit vectors

figure;
subplot(1,3,1);
imagesc(surfaceNormals(:,:,1), [-1 1]); colorbar; axis equal; axis tight; axis off;
title('X')

subplot(1,3,2);
imagesc(surfaceNormals(:,:,2), [-1 1]); colorbar; axis equal; axis tight; axis off;
title('Y')

subplot(1,3,3);
imagesc(surfaceNormals(:,:,3), [-1 1]); colorbar; axis equal; axis tight; axis off; 
title('Z')

