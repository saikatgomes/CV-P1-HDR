function [ B ,gRed, gGreen, gBlue] = solveSVD( zRed, zGreen, zBlue, imgCount, exposures, LAMDA, weights )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    B = zeros(size(zRed,1)*size(zRed,2), imgCount);

    fprintf('Creating exposures matrix B\n')
    for i = 1:imgCount
        B(:,i) = log(exposures(i));
    end
    
    % solve the system for each color channel
    [gRed]=gsolve(zRed, B, LAMDA, weights);
    [gGreen]=gsolve(zGreen, B, LAMDA, weights);
    [gBlue]=gsolve(zBlue, B, LAMDA, weights);

end

