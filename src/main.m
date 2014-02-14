function [] = main(directory)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [pixelArray,exposure] = readImages(directory);
    imgHDRfName=simpleHDR(directory,pixelrray);
    createHDR(pixelArray,exposure, smoothness);
    %distortColorC(directory,imgHDRfName);
    %createHDR(directory,pixelArray,exposure);
    %createToneMap(directory,pixelArray,exposure);
    
end

