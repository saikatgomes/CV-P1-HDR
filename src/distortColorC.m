function [ ] = distortColorC(directory,fileName)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here    

    img = strcat(directory,'/',fileName); %name of image file
    img=char(img);
    currentImage=imread(img);   %get pixel data value for this pic
    copyCurImg=currentImage;
    row=size(currentImage,1);
    col=size(currentImage,2);
    
    for color=1:3
        currentImage=copyCurImg;
        for r=1:row
            for c=1:col    
                currentImage(r,c,color)=0;
            end        
        end
        currentImage=uint8(currentImage);
        grayFileName=strcat(int2str(color),'-',fileName);
        imwrite(currentImage,strcat(directory,'/',grayFileName));        
    end
      

end

