function [newMap] = createToneMap(directory,pixelArray,logExposure1,logExposure2,logExposure3,logT)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


rows=size(pixelArray,2);
cols=size(pixelArray,3);
p=size(pixelArray,1);

newMap=zeros(rows,cols,3);

max1=0;
min1=999999;
max2=0;
min2=999999;
max3=0;
min3=999999;

% files = {'../Images/MemorialTest/memorial0061.png', '../Images/Memorial/memorial0065.png',...
%     '../Images/Memorial/memorial0070.png'};
% expTimes = [1/0.03125, 1/0.5,1/16];

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

% hdr = makehdr(files, 'ExposureValues', expTimes );
% %hdr = makehdr(files, 'RelativeExposure', expTimes ./ expTimes(1));
% rgb = tonemap(hdr);
% %figure; imshow(rgb)
% %figure; imshow(hdr)


for r=1:rows
    for c=1:cols
        num1=0;
        den1=0;
        num2=0;
        den2=0;
        num3=0;
        den3=0;
        for j=1:p
            pixVal=double(pixelArray(p,r,c,1)+1);
            w=double(weight(0,255,pixVal));
            num1=num1+(w*(logExposure1(pixVal)-logT(p)));
            den1=den1+(w);
            
            pixVal=double(pixelArray(p,r,c,2)+1);
            w=double(weight(0,255,pixVal));
            num2=num2+(w*(logExposure2(pixVal)-logT(p)));
            den2=den2+(w);
            
            pixVal=double(pixelArray(p,r,c,3)+1);
            w=double(weight(0,255,pixVal));
            num3=num3+(w*(logExposure3(pixVal)-logT(p)));
            den3=den3+(w);
        end
        E1=log(double(num1/den1));
        E2=log(double(num2/den2));
        E3=log(double(num3/den3));
        if(max1<exp(E1))
           max1=exp(E1); 
        end
        if(min1>exp(E1))
            min1=exp(E1);
        end
        if(max2<exp(E2))
           max2=exp(E2); 
        end
        if(min2>exp(E2))
            min2=exp(E2);
        end
        if(max3<exp(E3))
           max3=exp(E3); 
        end
        if(min3>exp(E3))
            min3=exp(E3);
        end
        newMap(r,c,1)=exp(E1);
        newMap(r,c,2)=exp(E2);
        newMap(r,c,3)=exp(E3);
        
    end        
end

for i = 1:rows
    for j = 1:cols
        newMap(i,j,1)=(((newMap(i,j,1)-min1)/(max1-min1))*255);
        newMap(i,j,2)=(((newMap(i,j,2)-min2)/(max2-min2))*255);
        newMap(i,j,3)=(((newMap(i,j,3)-min3)/(max3-min3))*255);
    end
end

newMap=uint8(newMap);
%imshow(newMap);

imgToneMap=strcat('toneMap-',datestr(now,'mm-dd-yyyy-HH-MM-SS-FFF'),'.tif');
imwrite(newMap,strcat(directory,'/',imgToneMap));