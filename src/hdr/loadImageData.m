%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Load image data and prepare for HDR processing
%--------------------------------------------------------------------------

function [fNames,T,imgCount,wts,pixelsRed,pixelsGreen, ...
    pixelsBlue] = loadImageData(directory)

    infoFile = dir(strcat(directory,'*.info'));    %info file
    infoFileName=infoFile(1).name;

    fid=fopen(strcat(directory,'',infoFileName));
    tLine=fgets(fid);   %file line is the pic count
    count=str2num(tLine);
    T = zeros(count,1);  %initialize vector
    tLine=fgets(fid);   %next line
    for i=1:count
        lineVal=strsplit(tLine);    %split each line on spaces
        img = strcat(directory,'',lineVal(1)); %name of image file
        img=char(img);
        display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Loading image: ',img));
        T(i)=1/str2double(lineVal(2)); %exposure value for this file
        fNames{i}=img;
        tLine=fgets(fid);   %read next line
    end
    fclose(fid);

    [T idx] = sort(T);
    fNames = fNames(idx);
    T = T(end:-1:1);
    fNames = fNames(end:-1:1);
    
    numOfImages = size(fNames,2);
    
    tmpImg = imread(fNames{1});
    pixelCount = size(tmpImg,1) * size(tmpImg,2);
    imgCount = size(fNames,2);

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
    n = pixelCount / numOfPixelsReq;
    sampleIdx = floor((1:n:pixelCount));
    sampleIdx = sampleIdx';
    
    pixelsRed = zeros(numOfPixelsReq, numOfImages);
    pixelsGreen = zeros(numOfPixelsReq, numOfImages);
    pixelsBlue = zeros(numOfPixelsReq, numOfImages);
    
    for i=1:numOfImages
        image = imread(fNames{i});            
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

