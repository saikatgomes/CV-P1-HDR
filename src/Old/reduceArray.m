function [reducedPixelArray] = reduceArray(pixelArray,numPhotos, minZ, maxZ)
% reduceArray : returns the pixel array reduced in size
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: pixelArray - 4d array of pixels
%           numPhotos - the number of photos
%           minZ - the minimum Z value
%           maxZ - the maximum Z value
%   Return: reducedPixelArray - the pixel array reduced in size
%--------------------------------------------------------------------------

pixelsNecessary = ceil((maxZ - minZ) / numPhotos);

end

