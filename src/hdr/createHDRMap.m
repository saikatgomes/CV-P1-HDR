%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Generates a hdr radiance map from a set of pictures
%--------------------------------------------------------------------------
function [hdrMap] = createHDRMap(fNames,g_Red,g_Green,g_Blue,w,B)

    numOfImages = size(fNames,2);
    image = imread(fNames{1});
    hdrMap = zeros(size(image));
    sum = zeros(size(image));
    
    for i=1:numOfImages

        image = double(imread(fNames{i}));

        pixWt = w(image + 1);        
        sum = sum + pixWt;
        
        mp(:,:,1) = (g_Red(image(:,:,1) + 1) - B(1,i));
        mp(:,:,2) = (g_Green(image(:,:,2) + 1) - B(1,i));
        mp(:,:,3) = (g_Blue(image(:,:,3) + 1) - B(1,i));
                
        % If a pixel is saturated        
        sPixls = ones(size(image));                
        sPixls_R = find(image(:,:,1) == 255);
        sPixls_G = find(image(:,:,2) == 255);
        sPixlsB = find(image(:,:,3) == 255);
            
        D = size(image,1) * size(image,2);
 
        sPixls(sPixls_R) = 0;
        sPixls(sPixls_R + D) = 0;
        sPixls(sPixls_R + 2*D) = 0;
           
        sPixls(sPixls_G) = 0;
        sPixls(sPixls_G + D) = 0;
        sPixls(sPixls_G + 2*D) = 0;
            
        sPixls(sPixlsB) = 0;
        sPixls(sPixlsB + D) = 0;
        sPixls(sPixlsB + 2*D) = 0;

        % weighted sum        
        hdrMap = hdrMap + (pixWt .* mp);
        
        % remove saturated pixels from the radiance map and the sum 
        hdrMap = hdrMap .* sPixls;
        sum = sum .* sPixls;
    end
    
    sPixelIdx = find(hdrMap == 0);
    hdrMap(sPixelIdx) = mp(sPixelIdx);
    sum(sPixelIdx) = 1;     % avoid division by zero
    
    % normalize
    hdrMap = hdrMap ./ sum;
    hdrMap = exp(hdrMap);
    
    
    

    


