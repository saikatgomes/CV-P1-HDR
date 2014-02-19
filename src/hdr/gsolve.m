%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------
function [g]=gsolve(pixAr,B,l,w)
    n = 256;
    A = zeros(size(pixAr,1)*size(pixAr,2)+n+1,n+size(pixAr,1));
    b = zeros(size(A,1),1);

    % Include the data-fitting equations
    k = 1;
    for i=1:size(pixAr,1)
        for j=1:size(pixAr,2)
            wij = w(pixAr(i,j)+1);
            A(k,pixAr(i,j)+1) = wij;
            A(k,n+i) = -wij;
            b(k,1) = wij * B(i,j);
            k=k+1;
        end
    end

    % Fix the curve by setting its middle value to 0
    A(k,129) = 1;
    k=k+1;
    
    % Include the smoothness equations 
    %Second derivative values being set
    %i.e. g"(z) = g(z-1) - 2*g(z) + g(z+1)
    for i=1:n-2
        A(k,i)=l*w(i+1); A(k,i+1)=-2*l*w(i+1); A(k,i+2)=l*w(i+1);
        k=k+1;
    end
    
    % Solve the system using SVD
    x = A\b;
    g = x(1:n);
    lE = x(n+1:size(x,1));
    
