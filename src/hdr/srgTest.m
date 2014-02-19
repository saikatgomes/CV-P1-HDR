function [  ] = srgTest(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    processHDR('../../Images/museumHDR/',[1 10 50 100 150],[.6 .8 1 1.1 1.2 1.5 2],[.72 .8 .9 1 1.1],[1 2 3 4 5 5.5 6 7 8 9 10 11 12 13 14]);
    processHDR('../../Images/farm/',[1 10 50 100 150],[.6 .8 1 1.1 1.2 1.5 2],[.72 .8 .9 1 1.1],[1 2 3 4 5 5.5 6 7 8 9 10 11 12 13 14]);
    %processHDR('../../Images/Memorial/',[1 10 50 100 150],[.6 .8 1 1.1 1.2 1.5 2],[.72 .8 .9 1 1.1],[1 2 3 4 5 5.5 6 7 8 9 10 11 12 13 14]);

end

