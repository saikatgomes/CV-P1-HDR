function [ filenames, exposures, numExposures ] = readImages(directory)
%UNTITLED2 Summary of this function goes here
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
    

end

