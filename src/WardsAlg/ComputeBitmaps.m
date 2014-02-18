function [thresholdBitmap,exclusionBitmap] = ComputeBitmaps(img,tolerance,percentileVal)
% ComputeBitmaps : compute threshold and exclusion bitmaps for img
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: img - 2-d image
%           tolerance - the tolerance for exclusion bitmap (use 5 as
%           default)
%           medianValue - the median value to used based on if image is too
%           light, too dark, or has good balance
%
%   Return: thresholdBitmap - threshold bitmap for img
%           exclusionBitmap - exclusion bitmap for img
%--------------------------------------------------------------------------


%medVal = median(img(:));
percentile = prctile(img(:),percentileVal,1);
thresholdBitmap = zeros(size(img,1), size(img,2));
exclusionBitmap = zeros(size(img,1), size(img,2));
for row = 1:size(img,1)
    for column = 1:size(img,2)
        currPix = img(row,column);
        if currPix > percentile
            thresholdBitmap(row,column) = 1;
        else
            thresholdBitmap(row,column) = 0;
        end
        if (currPix > (percentile + tolerance)) || (currPix < (percentile - tolerance))
            exclusionBitmap(row,column) = 1;
        else
            exclusionBitmap(row,column) = 0;
        end
    end
end
end

