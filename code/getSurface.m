function  heightMap = getSurface(surfaceNormals, method)
% GETSURFACE computes the surface depth from normals
%   HEIGHTMAP = GETSURFACE(SURFACENORMALS, IMAGESIZE, METHOD) computes
%   HEIGHTMAP from the SURFACENORMALS using various METHODs.
%
% Input:
%   SURFACENORMALS: height x width x 3 array of unit surface normals
%   METHOD: the intergration method to be used
%
% Output:
%   HEIGHTMAP: height map of object

[imageHeight,imageWidth,channel] = size(surfaceNormals);
heightMap = zeros(imageHeight,imageWidth);
output = zeros(imageHeight,imageWidth);
output1 = zeros(imageHeight,imageWidth);
normal_x = surfaceNormals(:,:,1);
normal_y = surfaceNormals(:,:,2);
normal_z = surfaceNormals(:,:,3);
x_derivative = normal_x./normal_z;
y_derivative = normal_y./normal_z;
X_Sum = cumsum(x_derivative,2);
Y_Sum =cumsum(y_derivative);
switch method
    case 'column'
        %         heightMap(1,2:imageWidth) = cumsum(x_derivative(1,2:imageWidth),2);
        %         for i=2:imageHeight
        %             for j= 1:imageWidth
        %                 heightMap(i,j) =  heightMap(i-1,j)+y_derivative(i,j);
        %             end
        %         end
        %
        output(1,2:imageWidth) = cumsum(x_derivative(1,2:imageWidth),2);
        output(2:imageHeight,:) = y_derivative(2:imageHeight,:);
        heightMap = cumsum(output);
        
        
    case 'row'
        output(2:imageHeight,1) = cumsum(y_derivative(2:imageHeight,1));
        output(:,2:imageWidth) = x_derivative(:,2:imageWidth);
        heightMap = cumsum(output,2);
        
        %         heightMap(2:imageHeight,1) = cumsum(y_derivative(2:imageHeight,1));
        %
        %         for j=2:imageWidth
        %             for i= 1:imageHeight
        %                 heightMap(i,j) =  heightMap(i,j-1)+x_derivative(i,j);
        %             end
        %         end
        
        
        
    case 'average'
        output(2:imageHeight,1) = cumsum(y_derivative(2:imageHeight,1));
        output(:,2:imageWidth) = x_derivative(:,2:imageWidth);
        
        output1(1,2:imageWidth) = cumsum(x_derivative(1,2:imageWidth));
        output1(2:imageHeight,:) = y_derivative(2:imageHeight,:);
        heightMap = (cumsum(output1)+cumsum(output,2))./2;
        %         Col = zeros(imageHeight,imageWidth);
        %         Row = zeros(imageHeight,imageWidth);
        %         Row(2:imageHeight,1) =cumsum(y_derivative(2:imageHeight,1));
        %         Col(1,2:imageWidth) = cumsum(x_derivative(1,2:imageWidth));
        %
        %         for j=2:imageWidth
        %             for i= 1:imageHeight
        %                 Row(i,j) =  Row(i,j-1)+x_derivative(i,j);
        %             end
        %         end
        %         for i=2:imageHeight
        %             for j= 1:imageWidth
        %                 Col(i,j) =  Col(i-1,j)+y_derivative(i,j);
        %             end
        %         end
        %         heightMap = (Col+Row)./2;
    case 'random'
        heightMap(2:imageHeight,1) = Y_Sum(2:imageHeight,1);
        heightMap(1,2:imageWidth) = X_Sum(1,2:imageWidth);
        for i = 2:imageHeight
            for j = 1:imageWidth
                currentValue = 0;
                count = 0;
                for p = 1:i-1
                    if( j-p >= 1 )
                        currentValue = currentValue+Y_Sum(1+p)+X_Sum(1+p,j-p)+Y_Sum(i,j-p)-Y_Sum(1+p,j-p)+X_Sum(i,j)-X_Sum(i,j-p);
                        count= count+1;
                    end
                end
                if(i==2 || i== imageHeight || p == i )
                    currentValue = currentValue+Y_Sum(i,1)+X_Sum(i,j);
                    count = count+1;
                end
                heightMap(i,j) = currentValue/count;
            end
        end
        
        
end

