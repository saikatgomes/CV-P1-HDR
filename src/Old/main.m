function [] = main(directory)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [pixelArray,T] = readImages(directory);
    weights = [];
    for i=1:256
        if i <= 0.5 * (1 + 256)
            weights(i) = ((i - 1) + 1); % never let the weights be zero because that would influence the equation system!!!
        else
            weights(i) = ((256 - i) + 1);
        end
    end
    weights
    %[hdr, rgb]=createHDR(pixelArray,T, 5);
    %[logExposure2,irradiance2]=createHDR(pixelArray,T, 1,2);
    %[logExposure3,irradiance3]=createHDR(pixelArray,T, 1,3);
    %[newMap] = createToneMap(directory,pixelArray,logExposure1,logExposure2,logExposure3,logT);
    %[newMap] = createToneMapSmooth(directory,pixelArray,logExposure1,logExposure2,logExposure3,logT);
    
end


