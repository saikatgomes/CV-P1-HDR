function [pixelArray,exposure] = test_readImages(directory,extension)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

imageFiles = dir(strcat(directory,'/*.',extension));


display(strcat(directory,'/*.',extension));
fileNum=length(imageFiles);
exposure=zeros(fileNum,1);
display(fileNum);

fileNames=cell(fileNum);

for i=1:fileNum
    currentFileName=imageFiles(i).name;
    fileNames(i)=cellstr(currentFileName);
    currentImage=imread(currentFileName);
    if ~exist('pixelArray','var') 
        row=size(currentImage,1);
        col=size(currentImage,2);    
        pixelArray = zeros(fileNum,row,col,3);
    end    
    
%    display(zVal);
%    for r=1:row
%         for c=1:col    
%             for z=1:3
%                 pixelArray(i,r,c,z) = currentImage(r,c,z);
%                 anotherA(r,c,z) = currentImage(r,c,z);
%             end
%         end        
%    end
%    if isequal(anotherA,currentImage)
%        display('sucks son!');       
%    end
%    

    pixelArray(i,:,:,:)=currentImage;
    pixelArray=uint8(pixelArray);
      
end
%fileNames = cellstr(fileNames);

fid=fopen(strcat(directory,'/exp.txt'));
tline=fgets(fid);
count=1;
while ischar(tline)
        exposure(count)=str2double(tline);
        tline=fgets(fid);
        count=count+1;
end
fclose(fid);

%%%% more dumb stuff!!!!!
imgNew=zeros(row,col,3);
display(row);
for i=1:fileNum
    for r=1:row
        for c=1:col    
        imgNew(r,c,1)=imgNew(r,c,1) +pixelArray(i,r,c,1)/fileNum;
        imgNew(r,c,2)=imgNew(r,c,2) +pixelArray(i,r,c,2)/fileNum;
        imgNew(r,c,3)=imgNew(r,c,3) +pixelArray(i,r,c,3)/fileNum;
        
        
%         imgNew(r,c,1)=pixelArray(i,r,c,1);
%         imgNew(r,c,2)=pixelArray(i,r,c,2);
%         imgNew(r,c,3)=pixelArray(i,r,c,3);
        end        
    end
end

fileNames = {'Capture_00031_RT8.TIF','Capture_00032_RT8.TIF','Capture_00033_RT8.TIF','Capture_00034_RT8.TIF','Capture_00035_RT8.TIF','Capture_00036_RT8.TIF','Capture_00037_RT8.TIF','Capture_00038_RT8.TIF'};
display(exposure);

newHDR=makehdr(fileNames,'RelativeExposure',exposure');
imwrite(newHDR,strcat(directory,'/','matLabHDR.tif'));




    imgNew=uint8(imgNew);
    imwrite(imgNew,strcat(directory,'/','poorManHDR.tif'));
    
    
    


