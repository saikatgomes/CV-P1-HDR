function [  ] = processHDR( directory , LAMDA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    timeStamp=datestr(now,'mmddyyyyHHMMSSFFF');
    mkdir(strcat('HDR',timeStamp));

% % % 
% % %     warning('off','all');
% % %     saturation = 0.6;
% % %     eps = 0.05;
% % %     phi = 8;
% % %     a = 0.72;
% % % 
% % %     [ filenames, exposures, imgCount,numPixels, ...
% % %         weights, zRed, zGreen, zBlue, sampleIndices ] = ...
% % %         loadImageData( directory );
% % % 
% % %     [ B, gRed, gGreen, gBlue] = solveSVD( zRed, zGreen, zBlue, ...
% % %         imgCount, exposures, LAMDA, weights );
% % %     
% % %     hdrMap = createHDRMap( filenames, gRed, gGreen, gBlue, weights, B );
% % %     [ldrLocal]  = reinhardLocal(hdrMap, saturation, eps, phi);
% % %     [ldrGlobal] = reinhardGlobal( hdrMap, a, saturation );
% % %     %rgb = tonemap(hdrMap);
% % %     
% % %     
% % %     for i=[1,2,3,4,5,6,7,8,9,10]
% % %         rgb = tonemap(hdrMap,'AdjustLightness', [0.1 1], ...
% % %                    'AdjustSaturation', i, ...
% % %                    'NumberOfTiles', [25,25]);
% % %         figure 
% % %         imshow(rgb);    
% % %         title(strcat('HDR',i));
% % %     end
%     rgb = tonemap(hdrMap,'AdjustLightness', [0.1 1], ...
%                    'AdjustSaturation', 2, ...
%                    'NumberOfTiles', [25,25]);
%     
    
%     figure 
%     imshow(hdrMap);    
%     title('HDR');
%     hdrwrite(hdrMap,strcat(directory,'newHDR.hdr'));
    
%     figure 
%     imshow(rgb);    
%     title('Matlab Default');
%         
%     figure
%     imshow(ldrGlobal);
%     title('Reinhard global operator');
%     figure
%     imshow(ldrLocal);
%     title('Reinhard local operator');
    
    
%     imwrite(rgb,strcat(directory,'ToneMap-Matlab.jpg'));    
%     imwrite(ldrGlobal,strcat(directory,'ToneMap-Global.jpg'));
%     imwrite(ldrLocal,strcat(directory,'ToneMap-Local.jpg'));
    
    clear all;
end

