function [shifts_matrix] = GetAllShiftsWardAlg(pixArray,ref_index, max_shift, tolerance,shouldFilter)
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
%           shouldFilter - 1 to use edge filter, 0 if not
%
%   Return: shifts_matrix - a 2-d matrix with number of rows equal to the 
%                           number of images and 2 columns.  The
%                           1st column contains the x shift, and 2nd column 
%                           contains the y shift.  The row
%                           corresponds to the image number
%--------------------------------------------------------------------------

% compares everything in pix array to reference image

% numphotos = size(pixArray,1);
% shifts_matrix = zeros(numphotos,2);
% grayReferenceImg = GetGrayImage(pixArray(ref_index,:,:,:));
% for i = 1:numphotos
%     if i ~= ref_index
%         currGrayImg = GetGrayImage(pixArray(i,:,:,:));
%         curr_shifts = GetExpectedShift(grayReferenceImg,currGrayImg,max_shift,tolerance);
%         shifts_matrix(i,:) = curr_shifts;
%     end
% end

numphotos = size(pixArray,1);
if (ref_index > numphotos)
    display('ERROR: reference image must have index less than the number of photos');
    return;
end

shifts_matrix = zeros(numphotos,2);
%grayReferenceImg = GetGrayImage(pixArray(ref_index,:,:,:));
for i = 1:ref_index
    if i + 1 > ref_index
        break;
    end
    currGrayImg = GetGrayImage(pixArray(i,:,:,:));
    currRefImg = GetGrayImage(pixArray(i + 1,:,:,:));
    if (shouldFilter == 1)
        % filter to emphasize edges before estimating the shift
        h = fspecial('prewitt');
        currGrayImg = imfilter(currGrayImg,h);
        currRefImg = imfilter(currRefImg,h);
    end
    curr_shifts = GetExpectedShift(currRefImg,currGrayImg,max_shift,tolerance);
    shifts_matrix(i,:) = curr_shifts;
end

for j = ref_index:numphotos
    if j + 1 > numphotos
        break;
    end
    currGrayImg = GetGrayImage(pixArray(j + 1,:,:,:));
    currRefImg = GetGrayImage(pixArray(j,:,:,:));
    if (shouldFilter == 1)
        % filter to emphasize edges before estimating the shift
        h = fspecial('prewitt');
        currGrayImg = imfilter(currGrayImg,h);
        currRefImg = imfilter(currRefImg,h);
    end
    curr_shifts = GetExpectedShift(currRefImg,currGrayImg,max_shift,tolerance);
    shifts_matrix(j+1,:) = curr_shifts;
end

end

