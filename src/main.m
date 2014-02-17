function [newMap,hdr,rdb] = main(directory)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [pixelArray,logT] = readImages(directory);
    [logExposure,irradiance]=createHDR(pixelArray,logT, 1);
    [newMap,hdr,rdb] = createToneMap(directory,pixelArray,logExposure,logT);
    
end

