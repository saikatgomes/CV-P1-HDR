function [bm_ret] = BitmapAND(bm1,bm2)
% BitmapAND: get the "and" bitmap of bm1 and bm2
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: bm1 - first bitmap
%           bm2 - second bitmap
%   Return: bm_ret - the "and" bitmap
%--------------------------------------------------------------------------

bm_ret = zeros(size(bm1,1), size(bm1,2));
for row = 1:size(bm1,1)
    for column = 1:size(bm1:2)
        val1 = bm1(row,column);
        val2 = bm2(row,column);
        if (val1 == 1 && val2 == 1)
            bm_ret(row,column) = 1;
        else
            bm_ret(row,column) = 0;
        end
    end
end


end

