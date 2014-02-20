%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Load image data and prepare for HDR processing
%--------------------------------------------------------------------------

function [wts,pixelsRed,pixelsGreen, ...
    pixelsBlue] = loadImageDataWards(pixArray)

    numOfImages = size(pixArray,1);
    
    pixelCount = size(pixArray,2) * size(pixArray,3);

    wts = [];
    for i=1:256    
        if i <= 0.5 * (1 + 256)
            wts(i) = i;
        else
            wts(i) = 255-i;
        end        
    end
        
    % load and sample the images    
    % create a random sampling by choosing min number of pixels
    numOfPixelsReq = ceil(255*2 / (numOfImages - 1)) * 2;    
    n = pixelCount / numOfPixelsReq;
    sampleIdx = floor((1:n:pixelCount));
    sampleIdx = sampleIdx';
    
    pixelsRed = zeros(numOfPixelsReq, numOfImages);
    pixelsGreen = zeros(numOfPixelsReq, numOfImages);
    pixelsBlue = zeros(numOfPixelsReq, numOfImages);
    
    for i=1:numOfImages           
        redCh = pixArray(i,:,:,1);
        rTemp = redCh(sampleIdx);
        greenCh = pixArray(i,:,:,2);
        gTemp = greenCh(sampleIdx);
        blueCh = pixArray(i,:,:,3);
        bTemp = blueCh(sampleIdx);        
        pixelsRed(:,i) = rTemp;
        pixelsGreen(:,i) = gTemp;
        pixelsBlue(:,i) = bTemp;
    end  

end

