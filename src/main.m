function [newMap,pixelArray,hdr,rdb, logExposure, irradiance] = main(directory)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [pixelArray,logT] = readImages(directory);
    [logExposure,irradiance]=createHDR(pixelArray,logT, 0.5);
    [newMap,hdr,rdb] = createToneMap(directory,pixelArray,logExposure,logT);
    
end

