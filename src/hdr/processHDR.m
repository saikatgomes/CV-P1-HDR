%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------

function [  ] = processHDR( inDir, LAMDA, R_SAT, R_BRIGHT, M_SAT)
    
    outDir=strcat(inDir,'HDR_',datestr(now,'mmddyyyy_HHMMSSFFF'));
    mkdir(outDir);

    warning('off','all');
    eps = 0.05;
    phi = 8;
    %saturation = 0.6;
    %a = 0.72;
    %simple average of pixels
    aveImg(inDir,outDir);

    for l=LAMDA
    
        [ fNames, T, imgCount, numPixels, ...
            wts, pixelsRed, pixelsGreen, pixelsBlue, sampleIndices ] = ...
            loadImageData(inDir);

        [ B, g_Red, g_Green, g_Blue] = solveSVD( pixelsRed, pixelsGreen, pixelsBlue, ...
            imgCount, T, l, wts, outDir);

        hdrMap = createHDRMap( fNames, g_Red, g_Green, g_Blue, wts, B );
        hdrwrite(hdrMap,strcat(outDir,'/imageHDR-',num2str(l),'.hdr'));
        for i=M_SAT
            rgb = tonemap(hdrMap,'AdjustLightness', [0.1 1], ...
                       'AdjustSaturation', i, ...
                       'NumberOfTiles', [25,25]);
            imwrite(rgb,strcat(outDir,'/ToneMap-Matlab-',num2str(i),'-',num2str(l),'.jpg'));  
        end

        for sat=R_SAT
            [ldrLocal]  = reinhardLocalToneMap(hdrMap, sat, eps, phi);
            imwrite(ldrLocal,strcat(outDir,'/ToneMap-Local',num2str(sat*1000),'-',num2str(l),'.jpg'));   
            for bright=R_BRIGHT            
                [ldrGlobal] = reinhardGlobalToneMap( hdrMap, bright, sat );     
                imwrite(ldrGlobal,strcat(outDir,'/ToneMap-Global-',num2str(sat*1000),'-',num2str(bright*1000),'-',num2str(l),'.jpg'));
            end  
        end      
    end
    clear all;
end
