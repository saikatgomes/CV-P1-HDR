function [grayImage] = GetGrayImage(img)
% GetGrayImage : get gray version of img passed in
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: img - 4-d where 4th dimension is 1,2, or 3 for RGB
%   Return: grayImage - a 2-D gray version of this image used for Ward's alg
%--------------------------------------------------------------------------

grayImage = zeros(size(img,2), size(img,3));
for row = 1:size(img,2)
    for column = 1:size(img,3)
        red = double(img(1,row,column,1));
        green = double(img(1,row,column,2));
        blue = double(img(1,row,column,3));
        grayImage(row,column) = (54*red + 183*green + 19*blue)/256;
    end
end

grayImage = uint8(grayImage);

end

