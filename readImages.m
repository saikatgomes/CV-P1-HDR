function [pixelArray,exposure] = readImages(directory,extension)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

imageFiles = dir(strcat(directory,'/*.',extension));
fileNum=length(imageFiles);
exposure=zeros(fileNum,1);

for i=1:fileNum
    currentFileName=imageFiles(i).name;
    currentImage=imread(currentFileName);
    if ~exist('pixelArray','var') 
        row=size(currentImage,1);
        col=size(currentImage,2);        
        pixelArray = zeros(fileNum,row,col,3);
    end    
    pixelArray(i,:,:,:) = currentImage;
      
end

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
    for j=1:3
        pixelArray(i,:,:,j) = 0;      
        imgNew(:,:,:)=pixelArray(i,:,:,:);
        imwrite(imgNew,strcat(directory,'/','imgnew-', num2str(j),'-',num2str(i),'.tif'));
    end
end


