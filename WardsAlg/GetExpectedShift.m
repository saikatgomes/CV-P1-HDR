function [x_y_shift_amounts] = GetExpectedShift(referenceImg, img2, max_shift, tolerance)
% GetExpectedShift : get expected shift to align img2 with referenceImg
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: referenceImg - 2-d gray image.  This is the reference image 
%                           that is used to compare to the other image 
%                           that will be used. Use GetGrayImage function
%                           if referenceImg is in RGB form
%           img2 - 2-d gray image.  Use GetGrayImage if img2 is in RGB form
%           max_shift - the estimated maximum shift in bits necessary
%           tolerance - the distance from median value used to compute
%                       exclusion bitmaps
%
%   Return: x_y_shift_amounts - a vector with 2 elements.  The 1st element 
%           is the x offset and the 2nd element is the y offset
%--------------------------------------------------------------------------

x_y_shift_amounts = [0 0];
cur_shift = [0 0];
if max_shift > 0
    shrunkImg1 = ImageShrink2(referenceImg);
    shrunkImg2 = ImageShrink2(img2);
    cur_shift = GetExpectedShift(shrunkImg1,shrunkImg2,max_shift-1, tolerance);
    cur_shift(1) = cur_shift(1) * 2;
    cur_shift(2) = cur_shift(2) * 2;
else
    cur_shift(1) = 0;
    cur_shift(2) = 0;
end

percentile = CalculatePercentile(referenceImg, img2);
[tb1, eb1] = ComputeBitmaps(referenceImg, tolerance,percentile);
[tb2, eb2] = ComputeBitmaps(img2, tolerance,percentile);
imwrite(tb1,strcat('Dataset/bitmaps/map1_',num2str(max_shift),'_',datestr(now,'mmddyyyy_HHMMSSFFF'),'.jpg'));
imwrite(tb2,strcat('Dataset/bitmaps/map2_',num2str(max_shift),'_',datestr(now,'mmddyyyy_HHMMSSFFF'),'.jpg'));
min_error = size(img2,1) * size(img2,2);
for i = -1:1
    for j = -1:1
        shifted_tb2 = BitmapShift(tb2,i,j);
        shifted_eb2 = BitmapShift(eb2,i,j);
        diff_bitmaps = BitmapXOR(tb1,shifted_tb2);
        diff_bitmaps = BitmapAND(diff_bitmaps,eb1);
        diff_bitmaps = BitmapAND(diff_bitmaps,shifted_eb2);
        error = BitmapTotal(diff_bitmaps);
        if error < min_error
            x_y_shift_amounts(1) = cur_shift(1) + i;
            x_y_shift_amounts(2) = cur_shift(2) + j;
            min_error = error;
        end
    end
end


end







