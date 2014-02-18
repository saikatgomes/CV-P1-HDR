function [ imgHDRfName ] = simpleHDR(directory,pixelArray)
% simpleHDR Constructs a "simple" hdr image by averaging the pixel values 
%           over all of the images given to create a "simple" hdr image
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%           pixelArray a 4D array with the pixel data of all images read
%               pixelArray(n,r,c,rbg)
%                   n=image number
%                   r=row value
%                   c=column value
%                   rgb=1=R, 2=G, 3=B
%           exposure a vector containing the exposure values
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------

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
   
%     row=int32(row/10)
%     col=int32(col/10)
%     %newImg=zeros(uint8(row),uint8(col),3);
%     newImg=zeros(row,col,3);
%     for m=1:fileNum
%         for i =1:row
%             for j=1:col
%                 newImg(i,j,1)=pixelArray(m,i,j,1);
%                 newImg(i,j,2)=pixelArray(m,i,j,2);
%                 newImg(i,j,3)=pixelArray(m,i,j,3);
%             end
%             %newImg(i,j)
%         end
%         newImg=uint8(newImg);        
%         imwrite(newImg,strcat(directory,'/',int2str(m),'-srgTestimg.tif'));
%     end
    
    
    imgSimpleHDR=uint8(imgSimpleHDR);
 
    imgHDRfName=strcat('simpleHDR-',datestr(now,'mm-dd-yyyy-HH-MM-SS-FFF'),'.tif');
    imwrite(imgSimpleHDR,strcat(directory,'/',imgHDRfName));


