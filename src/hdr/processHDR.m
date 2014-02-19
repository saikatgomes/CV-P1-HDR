%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------

function [  ] = processHDR( inDir, LAMDA, R_SAT, R_BRIGHT, M_SAT)
    
    warning('off','all');
    outDir=strcat(inDir,'HDR_',datestr(now,'mmddyyyy_HHMMSSFFF'));
    mkdir(outDir);
    eps = 0.05;
    phi = 8;
    %saturation = 0.6;
    %a = 0.72;    
    display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
        ' Output dir created at ',outDir));
    display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
        ' Creating average image ... '));
    aveImg(inDir,outDir); %simple average of pixels
    display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
        ' Average image created.'));
    for l=LAMDA
    
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Loading image data ... '));
        [fNames,T,imgCount,wts,pixelsRed,pixelsGreen, ...
            pixelsBlue] = loadImageData(inDir);
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Image data loaded.'));

        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Estimate camera response curve ... '));
        [B,g_Red,g_Green,g_Blue] = getResponseCurve(pixelsRed,pixelsGreen, ...
            pixelsBlue,imgCount,T,l,wts,outDir);
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Camera response curve estimated. '));

        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Creating HDR file ... '));
        hdrMap = createHDRMap(fNames,g_Red,g_Green,g_Blue,wts,B);
        hdrwrite(hdrMap,strcat(outDir,'/imageHDR-',num2str(l),'.hdr'));
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' HDR file created ... '));
        
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Creating standard tonemap(s) ... '));
        for i=M_SAT
            rgb = tonemap(hdrMap,'AdjustLightness', [0.1 1], ...
                       'AdjustSaturation', i, ...
                       'NumberOfTiles', [25,25]);
            imwrite(rgb,strcat(outDir,'/ToneMap-Matlab-',num2str(i), ...
                '-',num2str(l),'.jpg'));  
        end
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Standard tonemap(s) created. '));

        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Creating Reinhard tonemap(s) ... '));
        for sat=R_SAT
            [ldrLocal]  = reinhardLocalToneMap(hdrMap,sat,eps,phi);
            imwrite(ldrLocal,strcat(outDir,'/ToneMap-Local', ...
                num2str(sat*1000),'-',num2str(l),'.jpg'));   
            for bright=R_BRIGHT            
                [ldrGlobal] = reinhardGlobalToneMap( hdrMap, bright, sat );     
                imwrite(ldrGlobal,strcat(outDir,'/ToneMap-Global-', ...
                    num2str(sat*1000),'-',num2str(bright*1000),'-', ... 
                    num2str(l),'.jpg'));
            end  
        end  
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Reinhard tonemap(s) created. '));    
    end
    clear all;
end
