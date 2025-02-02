function [shiftedCroppedPixArray] = ShiftPixelsAndCrop(shifts,pixArray)
% BitmapTotal : sum all bits in array to get error
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: shifts - the 2-d array of shifts
%           pixArray - the 4-d pixel array
%   Return: shiftedCroppedPixArray - pixel array after images are shifted and
%                                    cropped
%--------------------------------------------------------------------------

minElements = min(shifts);
maxElements = max(shifts);
minXshift = minElements(1);
maxXshift = maxElements(1);
minYshift = minElements(2);
maxYshift = maxElements(2);

numPhotos = size(pixArray,1);
numRows = size(pixArray,2);
numColumns = size(pixArray,3);

shiftedArray = zeros(numPhotos,numRows,numColumns,3);
display('Beginning to crop photos');
for photo = 1:numPhotos
    curr_shift_x = shifts(photo,1);
    curr_shift_y = shifts(photo,2); 
    for row = 1:numRows
        for column = 1:numColumns
            if column + curr_shift_x < 1 || column + curr_shift_x > numColumns || ...
                    row + curr_shift_y < 1 || row + curr_shift_y > numRows
                %Do nothing, leave pixel as 0
            else
                shiftedArray(photo,row + curr_shift_y, column + curr_shift_x,:) = pixArray(photo,row, column,:);
            end
        end
    end
end

shiftedCroppedPixArray = shiftedArray(:,maxYshift+1:(numRows-abs(minYshift)), maxXshift+1:(numColumns-abs(minXshift)),:);
display('Finished cropping photos');
end

