function [bm_ret] = BitmapXOR(bm1,bm2)
% BitmapXOR: get the "exclusive or" bitmap of bm1 and bm2
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: bm1 - first bitmap
%           bm2 - second bitmap
%   
%   Return: bm_ret - the "exclusive or" bitmap
%--------------------------------------------------------------------------

bm_ret = zeros(size(bm1,1), size(bm1,2));
for row = 1:size(bm1,1)
    for column = 1:size(bm1:2)
        val1 = bm1(row,column);
        val2 = bm2(row,column);
        if (val1 == 0 && val2 == 0) || (val1 == 1 && val2 == 1)
            bm_ret(row,column) = 0;
        else
            bm_ret(row,column) = 1;
        end
    end
end


end

