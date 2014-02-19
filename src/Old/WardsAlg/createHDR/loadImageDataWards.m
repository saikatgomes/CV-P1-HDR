function [weights,zRed, zGreen, zBlue] = loadImageDataWards(pixArray )
%  GetAllShiftsWardAlg - get all the x and y shift positions for all images
%                        relative to last image i.e. reference image
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: pixArray - 4-d pixel array
%
%   Return: 
%--------------------------------------------------------------------------

    fprintf('Computing weighting function\n');
    % precompute the weighting function value
    % for each pixel
    weights = (256);
    for i=1:256       
        if i <= 0.5 * (1 + 256)
            weights(i) = i;
        else
            weights(i) = ((256 - i) + 1);
        end
        
    end
    
    % Create the vector of sample indices    
    % We need N(P-1) > (Zmax - Zmin)
    % Assuming the maximum (Zmax - Zmin) = 255, 
    % N = (255 * 2) / (P-1) clearly fulfills this requirement
    numSamples = ceil(255*2 / (size(pixArray,1) - 1)) * 10;
    
    % create a random sampling matrix, telling us which
    % pixels of the original image we want to sample
    % using ceil fits the indices into the range [1,numPixels+1],
    % i.e. exactly the range of indices of zInput
    numPixels = size(pixArray,2) * size(pixArray,3);
    step = numPixels / numSamples;
    sampleIndices = floor((1:step:numPixels));
    sampleIndices = sampleIndices';
    
    
    % allocate resulting matrices
    zRed = zeros(numSamples, size(pixArray,1));
    zGreen = zeros(numSamples, size(pixArray,1));
    zBlue = zeros(numSamples, size(pixArray,1));
    
    for i=1:size(pixArray,1)
        
        % sample the image for each color channel        
        redChannel = pixArray(i,:,:,1);
        zRedTemp = redChannel(sampleIndices);

        greenChannel = pixArray(i,:,:,2);
        zGreenTemp = greenChannel(sampleIndices);

        blueChannel = pixArray(i,:,:,3);
        zBlueTemp = blueChannel(sampleIndices);
        
        % build the resulting, small image consisting
        % of samples of the original image
        zRed(:,i) = zRedTemp;
        zGreen(:,i) = zGreenTemp;
        zBlue(:,i) = zBlueTemp;
    end
    

end

