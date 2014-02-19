%--------------------------------------------------------------------------
%   Author: Saikat Gomes
%           Steve Lazzaro
%   CS 766 - Assignment 1
%   Params: directory - relative directory of the *.info file
%   Returns: name of simple hdr file created
%--------------------------------------------------------------------------
function [B,gR,gG,gB] = solveSVD(pixR,pixG,pixB,imgCount,T,l,wts,outputDir)

    B = zeros(size(pixR,1)*size(pixR,2), imgCount);
    for i = 1:imgCount
        B(:,i) = log(T(i));
    end
    
    % solve the system for each color channel
    [gR]=gsolve(pixR, B, l, wts);
    [gG]=gsolve(pixG, B, l, wts);
    [gB]=gsolve(pixB, B, l, wts);    
    
    xAxis = zeros(256,1);
    for i = 1:256
        xAxis(i,1) = i;
    end    
    f = figure();
    axis([-15 15 0 255])
    plot(gR,xAxis,'r','LineWidth',2);
    xlabel('log exposure X')
    ylabel('pixel value Z')
    title('Response Function for Red Channel');
    axis([-5 5 0 255])
    saveas(f,strcat(outputDir,'/redResposeCurve-',num2str(l),'.jpg'));
    plot(gG,xAxis,'g','LineWidth',2);
    xlabel('log exposure X')
    ylabel('pixel value Z')
    title('Response Function for Red Channel');
    axis([-5 5 0 255])
    saveas(f,strcat(outputDir,'/greenResposeCurve-',num2str(l),'.jpg'));
    plot(gB,xAxis,'b','LineWidth',2);
    xlabel('log exposure X')
    ylabel('pixel value Z')
    title('Response Function for Red Channel');
    axis([-5 5 0 255])
    saveas(f,strcat(outputDir,'/blueResposeCurve-',num2str(l),'.jpg'));
    close(f);  
    
end

