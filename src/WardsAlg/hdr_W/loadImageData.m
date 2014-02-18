function [ filenames, exposures, imgCount,numPixels, ...
    weights,zRed, zGreen, zBlue, sampleIndices  ] = ...
    loadImageData( directory )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


    infoFile = dir(strcat(directory,'*.info'));    %info file
    infoFileName=infoFile(1).name;

    fid=fopen(strcat(directory,'',infoFileName));
    tLine=fgets(fid);   %file line is the pic count
    count=str2num(tLine);
    exposures = zeros(count,1);  %initialize vector
    tLine=fgets(fid);   %next line
    for i=1:count
        lineVal=strsplit(tLine);    %split each line on spaces
        img = strcat(directory,'',lineVal(1)); %name of image file
        img=char(img);
        exposures(i)=1/str2double(lineVal(2)); %exposure value for this file
        filenames{i}=img;
        tLine=fgets(fid);   %read next line
    end
    fclose(fid);

    % sort ascending by exposure
    [exposures indices] = sort(exposures);
    filenames = filenames(indices);

    % then inverse to get descending sort order
    exposures = exposures(end:-1:1);
    filenames = filenames(end:-1:1);
    
    numExposures = size(filenames,2);
    
    fprintf('Opening test image\n');
    tmp = imread(filenames{1});

    numPixels = size(tmp,1) * size(tmp,2);
    imgCount = size(filenames,2);

    fprintf('Computing weighting function\n');
    % precompute the weighting function value
    % for each pixel
    weights = [];
    for i=1:256
        %weights(i) = weight(i,1,256);        
        if i <= 0.5 * (1 + 256)
            weights(i) = ((i - 1) + 1); % never let the weights be zero because that would influence the equation system!!!
        else
            weights(i) = ((256 - i) + 1);
        end
        
    end
        
    % load and sample the images
    %[zRed, zGreen, zBlue, sampleIndices] = makeImageMatrix(filenames, numPixels);
    
    % determine the number of differently exposed images
    numExposures = size(filenames,2);
    
    
    % Create the vector of sample indices    
    % We need N(P-1) > (Zmax - Zmin)
    % Assuming the maximum (Zmax - Zmin) = 255, 
    % N = (255 * 2) / (P-1) clearly fulfills this requirement
    numSamples = ceil(255*2 / (numExposures - 1)) * 10;
    
    % create a random sampling matrix, telling us which
    % pixels of the original image we want to sample
    % using ceil fits the indices into the range [1,numPixels+1],
    % i.e. exactly the range of indices of zInput
    step = numPixels / numSamples;
    sampleIndices = floor((1:step:numPixels));
    sampleIndices = sampleIndices';
    
    
    % allocate resulting matrices
    zRed = zeros(numSamples, numExposures);
    zGreen = zeros(numSamples, numExposures);
    zBlue = zeros(numSamples, numExposures);
    
    for i=1:numExposures
        
        % read the nth image
        image = imread(filenames{i});
        
        % sample the image for each color channel        
        redChannel = image(:,:,1);
        zRedTemp = redChannel(sampleIndices);

        greenChannel = image(:,:,2);
        zGreenTemp = greenChannel(sampleIndices);

        blueChannel = image(:,:,3);
        zBlueTemp = blueChannel(sampleIndices);
        
        % build the resulting, small image consisting
        % of samples of the original image
        zRed(:,i) = zRedTemp;
        zGreen(:,i) = zGreenTemp;
        zBlue(:,i) = zBlueTemp;
    end
    

end

