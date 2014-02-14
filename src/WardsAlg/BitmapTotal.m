function [err] = BitmapTotal(bitmap)
% BitmapTotal : sum all bits in array to get error
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: bitmap - the bitmap used to calculate error
%   Return: err - the error for a bitmap shift
%--------------------------------------------------------------------------

err = sum(bitmap(:));
end

