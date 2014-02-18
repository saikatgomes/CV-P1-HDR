function [updatedRGBmatrix] = finishToneMapGammaComp(radianceMatrix, type)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: radianceMatrix - matrix to convert. ASSUMES SCALED FROM 0 to
%                               255
%           type - 1 to use matlab tonemap function, 2 to use our tonemap which
%           converts to L*a*b and then uses gamma compression
%   Returns: The final rgb matrix after gamma compression done in L*a*b
%               form
%--------------------------------------------------------------------------

%TODO: convert radiance matrix to hdr
if type == 1
    updatedRGBmatrix = tonemap(double(radianceMatrix));
elseif type == 2
    %first convert 0 255 scale of irradiance values to 0,1
    scaled = radianceMatrix / 255;
    c = makecform('srgb2lab');
    labMatrix = applycform(scaled,c);
    labMatrix(:,:,1) = double(labMatrix(:,:,1)).^0.5;
    cBack = makecform('lab2srgb');
    updatedRGBmatrix = applycform(labMatrix, cBack);
end

end

