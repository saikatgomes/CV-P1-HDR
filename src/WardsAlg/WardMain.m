function [pixArrayShiftedNoFilter, pixArrayShiftedFilter] = WardMain(directory)

%  WardMain - Run Wards algorithm on images, then cut off image pixels
%  where appropriate and write them to files in Dataset folders
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file and images
%   
%   Returns: pixArrayShiftedNoFilter - the shifted pixel array without an
%            edge filter
%            pixArrayShiftedFilter - the shifted pixel array with an
%            edge filter
%
%--------------------------------------------------------------------------

addpath('./hdrWards');
ref_index = 1;
max_shift = 3; % use 3 as standard for speed so only assume max shift of +-16
tolerance = 3;
LAMDA = 100;
R_SAT = 0.6;
R_BRIGHT = 1;
M_SAT = 0.75;

[pixArray,exposures,filenames] = readImages(directory);

%%%% USE WARDS ALIGMENT BEFORE HDR WITHOUT FILTER %%%%

shiftsNoFilter = GetAllShiftsWardAlg(pixArray, ref_index, max_shift, tolerance, 0);
display('Shifts No Filter');
display(shiftsNoFilter);
pixArrayShiftedNoFilter = ShiftPixelsAndCrop(shiftsNoFilter,pixArray);

processHDRWards(directory, LAMDA, R_SAT, R_BRIGHT, M_SAT, pixArrayShiftedNoFilter, exposures, filenames);

%%%% USE WARDS ALIGMENT BEFORE HDR WITH FILTER %%%%

shiftsFilter = GetAllShiftsWardAlg(pixArray, ref_index, max_shift, tolerance, 1);
display('Shifts Filter');
display(shiftsFilter);
pixArrayShiftedFilter = ShiftPixelsAndCrop(shiftsFilter,pixArray);

processHDRWards(directory, LAMDA, R_SAT, R_BRIGHT, M_SAT, pixArrayShiftedFilter, exposures, filenames);

%%%% USE NORMAL HDR WITHOUT WARDS %%%%

display('Normal HDR');

processHDRWards(directory, LAMDA, R_SAT, R_BRIGHT, M_SAT, pixArray, exposures, filenames);

end