function [img_half] = ImageShrink2(img)
% ImageShrink2 : halfs the image in size
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: img - a 2D array with the pixel data of an image
%   Return: img_half - a 2D array half the size
%--------------------------------------------------------------------------

% take every other pixel
%img_half = img(1:2:end,1:2:end);

% matlab resize function
img_half = imresize(img,'Scale',0.5,'Method','bicubic');

end

