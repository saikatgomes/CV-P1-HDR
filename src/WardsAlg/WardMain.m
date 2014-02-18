function [] = WardMain(directory)

%  WardMain - Run Wards algorithm on images, then cut off image pixels
%  where appropriate, and then process hdr images
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file and images
%
%   Return: 
%--------------------------------------------------------------------------

ref_index = 1;
max_shift = 3;
tolerance = 4;
shouldFilter = 1;
LAMDA = 50;

[pixArray,exposures,filenames] = readImages(directory);
shifts = GetAllShiftsWardAlg(pixArray, ref_index, max_shift, tolerance, shouldFilter);
pixArrayShifted = ShiftPixelsAndCrop(shifts,pixArray);

addpath ./createHDR
processHDRWards(pixArrayShifted,exposures,filenames,LAMDA);
rmpath ./createHDR

end