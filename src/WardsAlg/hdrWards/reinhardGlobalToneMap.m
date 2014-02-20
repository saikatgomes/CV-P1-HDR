%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Reinhard global tonemapping
%--------------------------------------------------------------------------
function [toneMappedPic] = reinhardGlobalToneMap(hdrMap,brightness,saturation)
    %std formula
    lumMap = 0.2125 * hdrMap(:,:,1) + 0.7154 * hdrMap(:,:,2) + 0.0721 * hdrMap(:,:,3);
    pixelCount = size(hdrMap,1) * size(hdrMap,2);

    % avoid taking log(0)
    delta = 0.0001;

    % the subjective brightness of the image for humans
    key = exp((1/pixelCount)*(sum(sum(log(lumMap + delta)))));
    scaledLum = lumMap * (brightness/key);    
    ldrLuminanceMap = scaledLum ./ (scaledLum + 1); % range [0,1]
    toneMappedPic = zeros(size(hdrMap));

    % re-apply color according to Fattals paper 
    % "Gradient Domain High Dynamic Range Compression"
    for i=1:3   
        toneMappedPic(:,:,i) = ((hdrMap(:,:,i) ./ ...
            lumMap) .^ saturation) .* ldrLuminanceMap;
    end
    idx = find(toneMappedPic > 1);
    toneMappedPic(idx) = 1;










