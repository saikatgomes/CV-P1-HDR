function [pixelArray, newMap, logExposure1, logExposure2, logExposure3] = main(directory)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [pixelArray,logT] = readImages(directory);
    [logExposure1,irradiance1]=createHDR(pixelArray,logT, 1,1);
    [logExposure2,irradiance2]=createHDR(pixelArray,logT, 1,2);
    [logExposure3,irradiance3]=createHDR(pixelArray,logT, 1,3);
    [newMap] = createToneMap(directory,pixelArray,logExposure1,logExposure2,logExposure3,logT);
    %[newMap] = createToneMap(directory,pixelArray,logExposure1,logExposure2,logExposure3,logT);
    
end


