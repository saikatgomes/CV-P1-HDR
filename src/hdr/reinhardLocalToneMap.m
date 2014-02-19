%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Reinhard local tonemapping 
%--------------------------------------------------------------------------
function [toneMappedPic] = reinhardLocalToneMap(hdrMap,sat,eps,phi)
    
    lumMap = 0.2125 * hdrMap(:,:,1) + 0.7154 * hdrMap(:,:,2) + ...
        0.0721 * hdrMap(:,:,3);
    alpha = 1 / (2*sqrt(2));
    key = 0.18;    
    v1 = zeros(size(lumMap,1), size(lumMap,2), 8);
    v = zeros(size(lumMap,1), size(lumMap,2), 8);
      
    % calculate 9 gaussian filtered version of the hdr luminance map
    for scale=1:(8+1)
        s = 1.6 ^ (scale-1);
        sigma = alpha * s;
        kernelRad = ceil(2*sigma);
        kernelSize = 2*kernelRad+1;        
        gaussKerHori = fspecial('gaussian', [kernelSize 1], sigma);
        v1(:,:,scale) = conv2(lumMap, gaussKerHori, 'same');
        gaussKerVer = fspecial('gaussian', [1 kernelSize], sigma);
        v1(:,:,scale) = conv2(v1(:,:,scale), gaussKerVer, 'same');
    end
    
    for i = 1:8    
        v(:,:,i) = abs((v1(:,:,i)) - v1(:,:,i+1)) ./ ...
            ((2^phi)*key / (s^2) + v1(:,:,i));    
    end  
        
    sMap = zeros(size(v,1), size(v,2));
    
    for i=1:size(v,1)
        for j=1:size(v,2)
            for scale=1:size(v,3)
                % choose the biggest possible neighbourhood 
                if v(i,j,scale) > eps                    
                    if (scale == 1) 
                        sMap(i,j) = 1;
                    end
                    if (scale > 1)
                        sMap(i,j) = scale-1;
                    end                   
                    break;
                end
            end
        end
    end
       
    % manually assign the biggest possible scale.
    indx = find(sMap == 0);
    sMap(indx) = 8;    
    v1Final = zeros(size(v,1), size(v,2));

    % local luminance map 
    for x=1:size(v1,1)
        for y=1:size(v1,2)
            v1Final(x,y) = v1(x,y,sMap(x,y));
        end
    end
    
    % tonemapping
    lumCompressed = lumMap ./ (1 + v1Final);
    toneMappedPic = zeros(size(hdrMap));

    % re-apply color according to Fattals paper "Gradient Domain High Dynamic
    % Range Compression"
    for i=1:3
        toneMappedPic(:,:,i) = ((hdrMap(:,:,i) ./ lumMap) .^ sat) .* lumCompressed;
    end
    indices = find(toneMappedPic > 1);
    toneMappedPic(indices) = 1;
   
    
    
    
    
    
    
    
    
    
    
    
    