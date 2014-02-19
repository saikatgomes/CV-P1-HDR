function [] = WardMain(directory)

%  WardMain - Run Wards algorithm on images, then cut off image pixels
%  where appropriate, and then process hdr images
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file and images
%
%--------------------------------------------------------------------------

ref_index = 1;
max_shift = 3;
tolerance = 4;
LAMDA = 50;

[pixArray,exposures,filenames] = readImages(directory);

%%%% USE WARDS ALIGMENT BEFORE HDR WITHOUT FILTER %%%%

shiftsNoFilter = GetAllShiftsWardAlg(pixArray, ref_index, max_shift, tolerance, 0);
pixArrayShifted = ShiftPixelsAndCrop(shiftsNoFilter,pixArray);

addpath ./createHDR
processHDRWards(pixArrayShifted,exposures,filenames,LAMDA);
rmpath ./createHDR

%%%% USE WARDS ALIGMENT BEFORE HDR WITH FILTER %%%%

shiftsFilter = GetAllShiftsWardAlg(pixArray, ref_index, max_shift, tolerance, 1);
pixArrayShifted = ShiftPixelsAndCrop(shiftsFilter,pixArray);

addpath ./createHDR
processHDRWards(pixArrayShifted,exposures,filenames,LAMDA);
rmpath ./createHDR

%%%% NORMAL HDR %%%%

addpath ./createHDR
processHDRWards(pixArray,exposures,filenames,LAMDA);
rmpath ./createHDR

end