function [shifts_matrix] = GetAllShiftsWardAlg(pixArray,ref_index, max_shift, tolerance)
%  GetAllShiftsWardAlg - get all the x and y shift positions for all images
%                        relative to last image i.e. reference image
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: pixArray - 4-d pixel array
%           ref_index - the index for the reference image
%           max_shift - the estimated maximum shift in bits necessary
%           tolerance - the distance from median value used to compute
%                       exclusion bitmaps
%
%   Return: shifts_matrix - a 2-d matrix with number of rows equal to the 
%                           number of images and 2 columns.  The
%                           1st column contains the x shift, and 2nd column 
%                           contains the y shift.  The row
%                           corresponds to the image number
%--------------------------------------------------------------------------
% Treats last image in pixArray as reference image

shifts_matrix = zeros(size(pixArray,1),2);
grayReferenceImg = GetGrayImage(pixArray(ref_index,:,:,:));
for i = 1:size(pixArray,1)
    if i ~= ref_index
        currGrayImg = GetGrayImage(pixArray(i,:,:,:));
        curr_shifts = GetExpectedShift(grayReferenceImg,currGrayImg,max_shift,tolerance);
        shifts_matrix(i,:) = curr_shifts;
    end
end

end

