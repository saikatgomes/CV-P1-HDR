function [ ] = simpleHDR(directory,pixelArray)
% simpleHDR Summary of this function goes here
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Return: pixelArray a 4D array with the pixel data of all images read
%               pixelArray(n,r,c,rbg)
%                   n=image number
%                   r=row value
%                   c=column value
%                   rgb=1=R, 2=G, 3=B
%           exposure a vector containing the exposure values
%--------------------------------------------------------------------------

    fileNum=size(pixelArray,1);
    row=size(pixelArray,2);
    col=size(pixelArray,3);
    imgSimpleHDR=zeros(row,col,3);

    for i=1:fileNum
        for r=1:row
            for c=1:col    
            imgSimpleHDR(r,c,1)=imgSimpleHDR(r,c,1) +pixelArray(i,r,c,1)/fileNum;
            imgSimpleHDR(r,c,2)=imgSimpleHDR(r,c,2) +pixelArray(i,r,c,2)/fileNum;
            imgSimpleHDR(r,c,3)=imgSimpleHDR(r,c,3) +pixelArray(i,r,c,3)/fileNum;
            end        
        end
    end

    imgSimpleHDR=uint8(imgSimpleHDR);
    imwrite(imgSimpleHDR,strcat(directory,'/','simpleHDR-',datestr(now,'dd-mm-yyyy-HH-MM-SS-FFF'),'.tif'));

