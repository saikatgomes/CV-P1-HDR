function [ logExpAvg ] = getLogExpAvg(logExp, pixVal)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%currently takes 6 closest neighbors

logExpAvg = logExp(max(1, pixVal - 3)) + logExp(max(1, pixVal - 2)) + ...
    logExp(max(1, pixVal - 1)) + logExp(pixVal) + ...
    logExp(min(255, pixVal + 1)) + logExp(min(255, pixVal + 2)) + ...
    logExp(min(255, pixVal + 3));
logExpAvg = logExpAvg / 7;

end

