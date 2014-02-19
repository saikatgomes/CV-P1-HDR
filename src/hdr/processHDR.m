%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------

function [  ] = processHDR( directory , LAMDA, R_saturation, R_brightness,M_saturation)
    
    outputDir=strcat(directory,'HDR_',datestr(now,'mmddyyyy_HHMMSSFFF'));
    mkdir(outputDir);

    warning('off','all');
    %saturation = 0.6;
    eps = 0.05;
    phi = 8;
    %a = 0.72;
    
    aveImg(directory,outputDir);

    for l=LAMDA
    
        [ filenames, exposures, imgCount,numPixels, ...
            weights, zRed, zGreen, zBlue, sampleIndices ] = ...
            loadImageData( directory );

        [ B, gRed, gGreen, gBlue] = solveSVD( zRed, zGreen, zBlue, ...
            imgCount, exposures, l, weights, outputDir);

        hdrMap = createHDRMap( filenames, gRed, gGreen, gBlue, weights, B );
        hdrwrite(hdrMap,strcat(outputDir,'/imageHDR-',num2str(l),'.hdr'));
        for i=M_saturation
            rgb = tonemap(hdrMap,'AdjustLightness', [0.1 1], ...
                       'AdjustSaturation', i, ...
                       'NumberOfTiles', [25,25]);
            imwrite(rgb,strcat(outputDir,'/ToneMap-Matlab-',num2str(i),'-',num2str(l),'.jpg'));  
        end

        for saturation=R_saturation
            [ldrLocal]  = reinhardLocalToneMap(hdrMap, saturation, eps, phi);
            imwrite(ldrLocal,strcat(outputDir,'/ToneMap-Local',num2str(saturation*1000),'-',num2str(l),'.jpg'));   
            for a=R_brightness            
                [ldrGlobal] = reinhardGlobalToneMap( hdrMap, a, saturation );     
                imwrite(ldrGlobal,strcat(outputDir,'/ToneMap-Global-',num2str(saturation*1000),'-',num2str(a*1000),'-',num2str(l),'.jpg'));
            end  
        end      
    end
    clear all;
end
