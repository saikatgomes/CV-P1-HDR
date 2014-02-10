function [] = main(directory)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [pixelArray,exposure] = readImages(directory);
    simpleHDR(directory,pixelArray);
    %createHDR(directory,pixelArray,exposure);
    %createToneMap(directory,pixelArray,exposure);
    
end

