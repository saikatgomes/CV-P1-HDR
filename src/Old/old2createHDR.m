function [ hdr, rgb ] = createHDR(pixelArray,T, smoothness)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
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
    
    rows=size(pixelArray,2);
    cols=size(pixelArray,3);
    p=size(pixelArray,1);
    
    hdr=zeros(rows,cols,3);
        
    for color=1:3
        display(strcat('INFO: Processing color: ',num2str(color)));
        n = 256;   
        pixelsNecessary = ceil(256 / p)*10;
        A = zeros(p * pixelsNecessary + n + 1, n + pixelsNecessary);    
        b = zeros(size(A,1), 1);

        rand_row=randi([1,size(pixelArray,2)],pixelsNecessary,1);
        rand_col=randi([1,size(pixelArray,3)],pixelsNecessary,1);

        k = 1;   % keeps track from 1 to n*p
        for i = 1:pixelsNecessary    %size(pixelArray,2)
            for j = 1:p
                i_row=rand_row(i,1);
                j_col=rand_col(i,1);            
                w = weight(0,255,pixelArray(j,i_row,j_col,color) + 1);  %only R
                A(k, pixelArray(j,i_row,j_col,color) + 1) = w;            
                A(k, n + i) = -1*double(w);            
                b(k, 1) = double(w) * log(T(j,1));            
                k = k + 1;
            end
        end

        A(k, 129) = 1;
        k = k + 1;

        %Second derivative values being set
        %i.e. g"(z) = g(z-1) - 2*g(z) + g(z+1)
        for i = 1:n - 2
            A(k,i) = smoothness * weight(0,255,i + 1);
            A(k, i + 1) = -2 * smoothness * weight(0,255,i + 1);
            A(k, i + 2) = smoothness * weight(0,255,i + 1);
            k=k+1;
        end

        x = A\b;
        
        display('INFO: SVD Solved!');

        logExposure = x(1:n);
        irradiance = x(n + 1:size(x, 1));
         a = zeros(256,1);
         for i = 1:256
             a(i,1) = i;
         end
%         figure; plot(logExposure,a);
%         display(color);
%         display(logExposure);
%         display(irradiance);

        lnE=zeros(rows,cols);
        
        for r=1:rows
            for c=1:cols
                numerator=0;
                denominator=0;
                for j=1:p                    
                    pixVal=double(pixelArray(p,r,c,color)+1);
                    w=double(weight(0,255,pixVal));
                    numerator=numerator+(w*(logExposure(pixVal)-log(T(p))));
                    denominator=denominator+(w);                    
                end
                lnE(r,c)=double(numerator/denominator);
            end        
        end
                
        E = exp(lnE);
        E=E/E(128);
        
        %figure; plot(E,a);
                
        display('INFO: E Calculated!');
        
        for r=1:rows
            for c=1:cols
                hdr(r,c,color)=E(r,c);                
            end
        end
        
    end
        
    figure; imshow(hdr)
    rgb = tonemap(hdr);
    figure; imshow(rgb)
  
end
