function [img_half] = ImageShrink2(img)
% ImageShrink2 : halfs the image in size
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: img - a 2D array with the pixel data of an image
%   Return: img_half - a 2D array with every other pixel of an image
%--------------------------------------------------------------------------

img_half = img(1:2:end,1:2:end);

end

