function [logExposure,irradiance] = createHDR(pixelArray,exposure, smoothness)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%
%
%
%
%
%
%
%

    vals = 256;
    numPhotos = size(pixelArray,1);
    numPixels = size(pixelArray,2) * size(pixelArray,3);
    A = zeros(numPhotos * numPixels + vals + 1, vals + numPixels);
    b = zeros(size(A,1), 1);
    
    pixTotal = 1;   % keeps track from 1 to n*p
    pixPerImage = 1; % keeps track from 1 to n
    for i = 1:size(pixelArray,2)
        for j = 1:size(pixelArray,3)
            for k = 1:numPhotos
                wij = weight(0,255,pixelArray(k,i,j,1) + 1);
                A(pixTotal, pixelArray(k,i,j,1) + 1) = wij;
                A(pixTotal, vals + pixPerImage) = -wij;
                b(pixTotal, 1) = wij * exposure(k,1);
                pixTotal = pixTotal + 1;
            end
            pixPerImage = pixPerImage + 1;
        end
    end
    
    A(pixTotal, 129) = 1;
    pixTotal = pixTotal + 1;
    
    %Second derivative values being set
    %i.e. g"(z) = g(z-1) - 2*g(z) + g(z+1)
    for i = 1:vals - 2
        A(pixTotal,i) = smoothness * weight(0,255,i + 1);
        A(pixTotal, i + 1) = -2 * smoothness * weight(0,255,i + 1);
        A(pixTotal, i + 2) = smoothness * weight(0,255,i + 1);
    end
    
    x = A\b;
    
    logExposure = x(1:vals);
    irradiance = x(vals + 1:size(x, 1));
    
end

