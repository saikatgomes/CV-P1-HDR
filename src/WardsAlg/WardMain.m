function [] = WardMain(directory)

%  WardMain - Run Wards algorithm on images, then cut off image pixels
%  where appropriate and write them to files in Dataset folders
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file and images
%
%--------------------------------------------------------------------------

ref_index = 1;
max_shift = 7;
tolerance = 4;
LAMDA = 50;

[pixArray,exposures,filenames] = readImages(directory);

%%%% USE WARDS ALIGMENT BEFORE HDR WITHOUT FILTER %%%%

shiftsNoFilter = GetAllShiftsWardAlg(pixArray, ref_index, max_shift, tolerance, 0);
display('Shifts No Filter');
display(shiftsNoFilter);
pixArrayShiftedNoFilter = ShiftPixelsAndCrop(shiftsNoFilter,pixArray);

picture = zeros(size(pixArrayShiftedNoFilter,2), size(pixArrayShiftedNoFilter,3), 3);
for i = 1:size(pixArrayShiftedNoFilter,1)
    picture(:,:,:) = pixArrayShiftedNoFilter(i,:,:,:);
    imwrite(picture,strcat('Dataset/outputNoFilter/img_nofilter_',i,'_',datestr(now,'mmddyyyy_HHMMSSFFF'),'.jpg'));
end

%%%% USE WARDS ALIGMENT BEFORE HDR WITH FILTER %%%%

shiftsFilter = GetAllShiftsWardAlg(pixArray, ref_index, max_shift, tolerance, 1);
display('Shifts Filter');
display(shiftsFilter);
pixArrayShiftedFilter = ShiftPixelsAndCrop(shiftsFilter,pixArray);

for i = 1:size(pixArrayShiftedFilter,1)
    picture(:,:,:) = pixArrayShiftedFilter(i,:,:,:);
    imwrite(picture,strcat('Dataset/outputEdgeFilter/img_filter_',i,'_',datestr(now,'mmddyyyy_HHMMSSFFF'),'.jpg'));
end

end