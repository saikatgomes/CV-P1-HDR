function [  ] = processHDR( directory , LAMDA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    warning('off','all');
    saturation = 0.6;
    eps = 0.05;
    phi = 8;
    a = 0.72;

    [ filenames, exposures, imgCount,numPixels, ...
        weights, zRed, zGreen, zBlue, sampleIndices ] = ...
        loadImageData( directory );

    [ B, gRed, gGreen, gBlue] = solveSVD( zRed, zGreen, zBlue, ...
        imgCount, exposures, LAMDA, weights );
    
    hdrMap = createHDRMap( filenames, gRed, gGreen, gBlue, weights, B );
    [ldrLocal]  = reinhardLocal(hdrMap, saturation, eps, phi);
    [ldrGlobal] = reinhardGlobal( hdrMap, a, saturation );
    rgb = tonemap(hdrMap);
    
    
    figure 
    imshow(rgb);    
    title('Matlab Default');
    
    figure
    imshow(ldrGlobal);
    title('Reinhard global operator');
    figure
    imshow(ldrLocal);
    title('Reinhard local operator');
    
    clear all;
end

