function [w] = weight(minZ,maxZ,pixelValue)
% w is the weighting function for the different pixels
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: maxZ - the max pixel value
%           minZ - the min pixel value
%           pixelValue - the current pixel value to be weighted
%   Returns: weight for pixel value
%--------------------------------------------------------------------------
midZ = (maxZ + minZ) / 2.0;
if (pixelValue <= midZ) 
    w = pixelValue - minZ;
else
    w = maxZ - pixelValue;
end