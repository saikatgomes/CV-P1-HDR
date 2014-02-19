function [map_ret] = BitmapShift(bitmap, x, y)
% BitmapShift : shift bitmap (or just a 2d array of pixels) by x and y given
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: bitmap - the 2-d bitmap to shift
%           x - the x amount to shift
%           y - the y amount to shift
%
%   Return: map_ret - the shifted bitmap
%--------------------------------------------------------------------------

map_ret = zeros(size(bitmap,1),size(bitmap,2));
for row = 1:size(bitmap,1)
    for column = 1:size(bitmap,2)
        if column + x < 1 || column + x > size(bitmap,2) || row + y < 1 || row + y > size(bitmap,1)
            %Do nothing, leave pixel as 0
        else
            map_ret(row + y, column + x) = bitmap(row, column);
        end
    end
end

end

