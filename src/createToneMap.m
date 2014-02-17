function [newMap,hdr,rgb] = createToneMap(directory,pixelArray,logExposure,logT)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


rows=size(pixelArray,2);
cols=size(pixelArray,3);
p=size(pixelArray,1);

newMap=zeros(rows,cols,3);
size(logExposure,1)
size(logT,1)

max=0;
min=999999;

files = {'../Images/MemorialTest/memorial0061.png', '../Images/Memorial/memorial0065.png',...
    '../Images/Memorial/memorial0070.png'};
expTimes = [1/0.03125, 1/0.5,1/16];

% files = {'../Images/Memorial/memorial0061.png', '../Images/Memorial/memorial0062.png', ...
%     '../Images/Memorial/memorial0063.png', '../Images/Memorial/memorial0064.png', ...
%     '../Images/Memorial/memorial0065.png', '../Images/Memorial/memorial0066.png', ...
%     '../Images/Memorial/memorial0067.png', '../Images/Memorial/memorial0068.png', ...
%     '../Images/Memorial/memorial0069.png', '../Images/Memorial/memorial0070.png', ...
%     '../Images/Memorial/memorial0071.png', '../Images/Memorial/memorial0072.png', ...
%     '../Images/Memorial/memorial0073.png', '../Images/Memorial/memorial0074.png', ...
%     '../Images/Memorial/memorial0075.png', '../Images/Memorial/memorial0076.png'};
% expTimes = [1/0.03125,1/0.0625, 1/0.125, 1/0.25, 1/0.5, 1, 1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024];

% files = {'../Img/Memorial/memorial0061.png', '../Img/Memorial/memorial0062.png', ...
%     '../Img/Memorial/memorial0063.png', '../Img/Memorial/memorial0064.png', ...
%     '../Img/Memorial/memorial0065.png', '../Img/Memorial/memorial0066.png', ...
%     '../Img/Memorial/memorial0067.png', '../Img/Memorial/memorial0068.png', ...
%     '../Img/Memorial/memorial0069.png', '../Img/Memorial/memorial0070.png', ...
%     '../Img/Memorial/memorial0071.png', '../Img/Memorial/memorial0072.png', ...
%     '../Img/Memorial/memorial0073.png', '../Img/Memorial/memorial0074.png', ...
%     '../Img/Memorial/memorial0075.png', '../Img/Memorial/memorial0076.png'};
% expTimes = [1/0.03125,1/0.0625, 1/0.125, 1/0.25, 1/0.5, 1, 1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024];


% files = {'../Img/HDR/IMG_9495.tiff', '../Img/HDR/IMG_9496.tiff', ...
%     '../Img/HDR/IMG_9497.tiff'};
% expTimes = [1/2,1,2];

%hdr = makehdr(files);

hdr = makehdr(files, 'ExposureValues', expTimes );
%hdr = makehdr(files, 'RelativeExposure', expTimes ./ expTimes(1));
rgb = tonemap(hdr);
%figure; imshow(rgb)
%figure; imshow(hdr)


for r=1:rows
    for c=1:cols
        num=0;
        den=0;
        E=0;
        for j=1:p
            pixVal=double(pixelArray(p,r,c,1)+1);
            w=double(weight(0,255,pixVal));
            num=num+(w*(logExposure(pixVal)-logT(p)));
            den=den+(w);
        end
        E=double(num/den);
        if(max<exp(E))
           max=exp(E); 
        end
        if(min>exp(E))
            min=exp(E);
        end
%         newMap(r,c,1)=pixelArray(1,r,c,1)*exp(E);
%         newMap(r,c,2)=pixelArray(1,r,c,2)*exp(E);
%         newMap(r,c,3)=pixelArray(1,r,c,3)*exp(E);
        newMap(r,c,1)=exp(E);
        newMap(r,c,2)=exp(E);
        newMap(r,c,3)=exp(E);
        
    end        
end
display(max);
display(min);
%mult = 255/(max - min)

%newMap=(newMap-min)*double(mult);
for i = 1:rows
    for j = 1:cols
        newMap(i,j,1)=((newMap(i,j,1)-min)*255)/(max-min);
        newMap(i,j,2)=((newMap(i,j,2)-min)*255)/(max-min);
        newMap(i,j,3)=((newMap(i,j,3)-min)*255)/(max-min);
    end
end

%display(newMap);
%newMap=uint8(newMap);

imgToneMap=strcat('toneMap-',datestr(now,'mm-dd-yyyy-HH-MM-SS-FFF'),'.tif');
imwrite(newMap,strcat(directory,'/',imgToneMap));

