function [logExposure,irradiance] = createHDR(pixelArray,logT, smoothness)
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

    n = 256;
    p = size(pixelArray,1);    
    pixelsNecessary = ceil(256 / p)*2;
    A = zeros(p * pixelsNecessary + n + 1, n + pixelsNecessary);    
    b = zeros(size(A,1), 1);
    
    rand_row=randi([1,size(pixelArray,2)],pixelsNecessary,1);
    rand_col=randi([1,size(pixelArray,3)],pixelsNecessary,1);
    
    
    k = 1;   % keeps track from 1 to n*p
    for i = 1:pixelsNecessary    %size(pixelArray,2)
        for j = 1:p
            i_row=rand_row(i,1);
            j_col=rand_col(i,1);            
            w = weight(0,255,pixelArray(j,i_row,j_col,1) + 1);  %only R
            A(k, pixelArray(j,i_row,j_col,1) + 1) = w;            
            A(k, n + i) = -1*double(w);            
            b(k, 1) = double(w) * logT(j,1);            
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
    
    logExposure = x(1:n);
     a = zeros(256,1);
     for i = 1:256
         a(i,1) = i;
     end
    plot(a,logExposure);
    irradiance = x(n + 1:size(x, 1));
    
end

