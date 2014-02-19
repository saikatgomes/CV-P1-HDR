%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------


function [ B ,gRed, gGreen, gBlue] = solveSVD( zRed, zGreen, zBlue, imgCount, exposures, LAMDA, weights , outputDir)
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
    
    
    a = zeros(256,1);
    for i = 1:256
        a(i,1) = i;
    end
    
    f = figure();
    axis([-15 15 0 255])
    plot(gRed,a,'r','LineWidth',2);
    xlabel('log exposure X')
    ylabel('pixel value Z')
    title('Response Function for Red Channel');
    axis([-5 5 0 255])
    saveas(f,strcat(outputDir,'/redResposeCurve-',num2str(LAMDA),'.jpg'));
    plot(gGreen,a,'g','LineWidth',2);
    xlabel('log exposure X')
    ylabel('pixel value Z')
    title('Response Function for Red Channel');
    axis([-5 5 0 255])
    saveas(f,strcat(outputDir,'/greenResposeCurve-',num2str(LAMDA),'.jpg'));
    plot(gBlue,a,'b','LineWidth',2);
    xlabel('log exposure X')
    ylabel('pixel value Z')
    title('Response Function for Red Channel');
    axis([-5 5 0 255])
    saveas(f,strcat(outputDir,'/blueResposeCurve-',num2str(LAMDA),'.jpg'));
    close(f);
    
    
end

