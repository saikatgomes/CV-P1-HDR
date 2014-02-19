function [  ] = main( directory , LAMDA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    warning('off','all');

    [filenames, exposures, imgCount] = readImages(directory);
    
    fprintf('Opening test image\n');
    tmp = imread(filenames{1});

    numPixels = size(tmp,1) * size(tmp,2);
    imgCount = size(filenames,2);

    fprintf('Computing weighting function\n');
    % precompute the weighting function value
    % for each pixel
    weights = [];
    for i=1:256
        weights(i) = weight(i,1,256);
    end
    
    
    % load and sample the images
    [zRed, zGreen, zBlue, sampleIndices] = makeImageMatrix(filenames, numPixels);


    B = zeros(size(zRed,1)*size(zRed,2), imgCount);

    fprintf('Creating exposures matrix B\n')
    for i = 1:imgCount
        B(:,i) = log(exposures(i));
    end
    
    % solve the system for each color channel
    fprintf('Solving for red channel\n')
    [gRed,lERed]=gsolve(zRed, B, LAMDA, weights);
    fprintf('Solving for green channel\n')
    [gGreen,lEGreen]=gsolve(zGreen, B, LAMDA, weights);
    fprintf('Solving for blue channel\n')
    [gBlue,lEBlue]=gsolve(zBlue, B, LAMDA, weights);
    %save('gMatrix.mat','gRed', 'gGreen', 'gBlue');
    
    

    % compute the hdr radiance map
    fprintf('Computing hdr image\n')
    hdrMap = hdr(filenames, gRed, gGreen, gBlue, weights, B);

    %SRG
        %rgb = tonemap(hdrMap);
        %figure; imshow(rgb)
    %SRG
    
    
    
    % compute the hdr luminance map from the hdr radiance map. It is needed as
    % an input for the Reinhard tonemapping operators.
    fprintf('Computing luminance map\n');
    luminance = 0.2125 * hdrMap(:,:,1) + 0.7154 * hdrMap(:,:,2) + 0.0721 * hdrMap(:,:,3);

    % apply Reinhard local tonemapping operator to the hdr radiance map
    fprintf('Tonemapping - Reinhard local operator\n');
    saturation = 0.6;
    eps = 0.05;
    phi = 8;
    [ldrLocal, luminanceLocal, v, v1Final, sm ]  = reinhardLocal(hdrMap, saturation, eps, phi);


    
    % apply Reinhard global tonemapping oparator to the hdr radiance map
    fprintf('Tonemapping - Reinhard global operator\n');
    % specify resulting brightness of the tonampped image. See reinhardGlobal.m
    % for details
    a = 0.72;
    % specify saturation of the resulting tonemapped image. See reinhardGlobal.m
    % for details
    saturation = 0.6;
    [ldrGlobal, luminanceGlobal ] = reinhardGlobal( hdrMap, a, saturation );
    
    
    figure
    imshow(ldrGlobal);
    title('Reinhard global operator');
    figure
    imshow(ldrLocal);
    title('Reinhard local operator');

    fprintf('Finished!\n');
    
    clear all;
end

