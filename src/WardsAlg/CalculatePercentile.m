function [percentile] = CalculatePercentile(img1, img2)
% CalculateMedian : calculate what median value should be used
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: img1 - first 2-d image
%           img2 - second 2-d image
%
%   Return: percentile - percentile value to use.  If images are light it will
%                        return 17, if images are dark it will return 83, 
%                        or else it will return 50
%--------------------------------------------------------------------------

%assume both images have same amount of pixels
numpixelstotal = size(img1,1) * size(img1,2) * 2;
sumPixelsBothPics = sum(img1(:)) + sum(img2(:));
tooLightCutoff = 0.75 * numpixelstotal * 255;
tooDarkCutoff = 0.25 * numpixelstotal * 255;
if sumPixelsBothPics >= tooLightCutoff
    percentile = 17;
elseif sumPixelsBothPics <= tooDarkCutoff
    percentile = 83;
else
    percentile = 50;
end

% sumPixelsBothPics = 0;
% tooLightPercentage = 0.75;
% tooDarkPercentage = 0.25;
% tooLightCutoff = tooLightPercentage * 255;
% tooDarkCutoff = tooDarkPercentage * 255;
% countAboveLightCutoff = 0;
% countBelowDarkCutoff = 0;
% 
% for row = 1:size(img1,1)
%     for column = 1:size(img1,2)
%         sumPixelsBothPics = sumPixelsBothPics + img1(row,column) + img2(row,column);
%         if (img1(row,column) >= tooLightCutoff)
%             countAboveLightCutoff = countAboveLightCutoff + 1;
%         elseif (img2(row,column) <= tooDarkCutoff)
%             countBelowDarkCutoff = countBelowDarkCutoff + 1;
%         end
%     end
% end
% 
% numpixelstotal = size(img1,1) * size(img1,2) * 2;
% tooLightCutoffTotal = tooLightCutoff * numpixelstotal;
% tooDarkCutoffTotal = tooDarkCutoff * numpixelstotal;
% if sumPixelsBothPics >= tooLightCutoffTotal
%     display(17);
%     percentile = 17;
% elseif sumPixelsBothPics <= tooDarkCutoffTotal
%     percentile = 83;
% else
%     if (countAboveLightCutoff / numpixelstotal) >= 0.6
%         display(17);
%         percentile = 17;
%     elseif (countBelowDarkCutoff /numpixelstotal) <= 0.25
%         display(83);
%         percentile = 83;
%     else
%         percentile = 50;
%     end
% end

end
