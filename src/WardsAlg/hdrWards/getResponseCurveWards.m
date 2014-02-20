%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------
function [B,gR,gG,gB] = getResponseCurveWards(pixR,pixG,pixB,imgCount,T,l,wts)

    B = zeros(size(pixR,1)*size(pixR,2), imgCount);
    for i = 1:imgCount
        B(:,i) = log(T(i));
    end
    
    % solve the system for each color channel
    display(strcat(datestr(now,'HH:MM:SS'),' [INFO] ', ...
            ' Solving SVD ... '));
    [gR]=solveSVD(pixR, B, l, wts);
    [gG]=solveSVD(pixG, B, l, wts);
    [gB]=solveSVD(pixB, B, l, wts);
    
end

