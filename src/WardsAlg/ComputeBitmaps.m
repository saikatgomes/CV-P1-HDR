function [thresholdBitmap,exclusionBitmap] = ComputeBitmaps(img,tolerance)
% ComputeBitmaps : compute threshold and exclusion bitmaps for img
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: img - 2-d image
%           tolerance - the tolerance for exclusion bitmap (use 5 as
%           default)
%   Return: thresholdBitmap - threshold bitmap for img
%           exclusionBitmap - exclusion bitmap for img
%--------------------------------------------------------------------------

%TODO: SHOULD MEASURE IF MAJORITY OF PIXELS ARE WHITE OR BLACK TO KNOW
%       IF SHOULD USE 17TH OR 83RD PERCENTILE

vectorImg = reshape(img,1, size(img,1) * size(img,2));
medVal = median(vectorImg);
thresholdBitmap = zeros(size(img,1), size(img,2));
exclusionBitmap = zeros(size(img,1), size(img,2));
for int row = 1:size(img,1)
    for int column = 1:size(img,2)
        currPix = img(row,column);
        if (currPix > medVal)
            thresholdBitmap(row,column) = 1;
        else
            thresholdBitmap(row,column) = 0;
        end
        if (currPix > medVal + tolerance || currPix < medVal - tolerance)
            exclusionBitmap(row,column) = 1;
        else
            exclusionBitmap(row,column) = 0;
        end
    end
end
end

