function [] = aveImg(directory,outputDir)

    infoFile = dir(strcat(directory,'/*.info'));    %info file
    infoFileName=infoFile(1).name;

    fid=fopen(strcat(directory,'/',infoFileName));
    tLine=fgets(fid);   %file line is the pic count
    count=str2num(tLine);
    T = zeros(count,1);  %initialize vector
    tLine=fgets(fid);   %next line
    for i=1:count
        lineVal=strsplit(tLine);    %split each line on spaces
        img = strcat(directory,'/',lineVal(1)); %name of image file
        %display(strcat('Reading Image: ',img));
        img=char(img);
        T(i)=1/str2double(lineVal(2)); %exposure value for this file
        currentImage=imread(img);   %get pixel data value for this pic
        if ~exist('pixelArray','var')   %initialize array first time
            row=size(currentImage,1);   %assume same row & col for all images
            col=size(currentImage,2);    
            pixelArray = zeros(i,row,col,3);
        end        
        pixelArray(i,:,:,:)=currentImage;
        pixelArray=uint8(pixelArray);
        tLine=fgets(fid);   %read next line
    end
    fclose(fid);
        
    fileNum=size(pixelArray,1);
    row=size(pixelArray,2);
    col=size(pixelArray,3);
    imgSimpleHDR=zeros(row,col,3);

    for i=1:fileNum
        for r=1:row
            for c=1:col    
                imgSimpleHDR(r,c,1)=imgSimpleHDR(r,c,1) +pixelArray(i,r,c,1)/fileNum;
                imgSimpleHDR(r,c,2)=imgSimpleHDR(r,c,2) +pixelArray(i,r,c,2)/fileNum;
                imgSimpleHDR(r,c,3)=imgSimpleHDR(r,c,3) +pixelArray(i,r,c,3)/fileNum;
            end        
        end
    end
        
    imgSimpleHDR=uint8(imgSimpleHDR);
    imwrite(imgSimpleHDR,strcat(outputDir,'/averageImg.jpg'));
    
end


