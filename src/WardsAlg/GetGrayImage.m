function [grayImage] = GetGrayImage(img)
% GetGrayImage : get gray version of img passed in
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: img - 3-d where 3rd dimension is 1,2, or 3 for RGB
%   Return: grayImage - a 2-D gray version of this image used for Ward's alg
%--------------------------------------------------------------------------

grayImage = zeros(size(img,1), size(img,2));
for row = 1:size(img,1)
    for column = 1:size(img,2)
        red = img(row,column,1);
        green = img(row,column,2);
        blue = img(row,column,3);
        grayImage(row,column) = (54*red + 183*green + 19*blue)/256;
    end
end

end

