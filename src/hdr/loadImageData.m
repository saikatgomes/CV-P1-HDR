%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Load image data and prepare for HDR processing
%--------------------------------------------------------------------------

function [ filenames, exposures, imgCount, pixelCount, ...
    wts,pixelsRed, pixelsGreen, pixelsBlue, sampleIdx  ] = ...
    loadImageData( directory )

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

    [exposures idx] = sort(exposures);
    filenames = filenames(idx);
    exposures = exposures(end:-1:1);
    filenames = filenames(end:-1:1);
    
    numOfImages = size(filenames,2);
    
    tmpImg = imread(filenames{1});
    pixelCount = size(tmpImg,1) * size(tmpImg,2);
    imgCount = size(filenames,2);

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
    step = pixelCount / numOfPixelsReq;
    sampleIdx = floor((1:step:pixelCount));
    sampleIdx = sampleIdx';
    
    pixelsRed = zeros(numOfPixelsReq, numOfImages);
    pixelsGreen = zeros(numOfPixelsReq, numOfImages);
    pixelsBlue = zeros(numOfPixelsReq, numOfImages);
    
    for i=1:numOfImages
        image = imread(filenames{i});            
        redCh = image(:,:,1);
        rTemp = redCh(sampleIdx);
        greenCh = image(:,:,2);
        gTemp = greenCh(sampleIdx);
        blueCh = image(:,:,3);
        bTemp = blueCh(sampleIdx);        
        pixelsRed(:,i) = rTemp;
        pixelsGreen(:,i) = gTemp;
        pixelsBlue(:,i) = bTemp;
    end  

end

