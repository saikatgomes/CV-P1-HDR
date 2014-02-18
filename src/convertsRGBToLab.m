function [labMatrix] = convertsRGBToLab(sRGBMatrix)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: sRGBMatrix - matrix to conver. NOTE: should contain vals betw 0
%                        and 1.
%   Returns: 3-d lab form of matrix passed in
%--------------------------------------------------------------------------

c = makecform('srgb2lab');
labMatrix = applycform(sRGBMatrix,c);

end

