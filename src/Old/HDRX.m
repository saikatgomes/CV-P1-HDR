function [hdr, rgb, logE, points] = HDRX(directory)
%function [hdr, rgb, logE, points] = HDRX(fileName, T)
% This function is used to generate the HDR image from the image stacks.
% Written by: Mon-Ju Wu


    infoFile = dir(strcat(directory,'/*.info'));    %info file
    infoFileName=infoFile(1).name;

    fid=fopen(strcat(directory,'/',infoFileName));
    tLine=fgets(fid);   %file line is the pic count
    count=str2num(tLine);
    T = zeros(count,1);  %initialize vector
    tLine=fgets(fid);   %next line
    for i=1:count
        lineVal=strsplit(tLine);    %split each line on spaces
        img = strcat(directory,'/',lineVal(1)); %name of image file
        %display(strcat('Reading Image: ',img));
        img=char(img);
        %logT(i)=log(1/str2double(lineVal(2))); %exposure value for this file
        T(count)=str2double(lineVal(2));
        %currentImage=imread(img);   %get pixel data value for this pic
          tempImage = imread(img);
          RED(:,:,count) = tempImage(:,:,1);
          GREEN(:,:,count) = tempImage(:,:,2);
          BLUE(:,:,count) = tempImage(:,:,3);
        tLine=fgets(fid);   %read next line
    end
    fclose(fid);





% 
% % Acquire the image set and decompose every image into RED, GREEN, and
% % BLUE.
%   if fileName(end) ~= '\'
%       fileName = [fileName '\'];
%   end
%   fileDirect = fileName;
%   FilePath = fileDirect;
%   FileList = {};
%   FileExt = {'jpg','JPG','jpeg','JPEG'};
%   FileList = dig(FilePath,FileList,FileExt,1);
%   for s = 1:size(FileList,1)
%       if nargin == 1
%           info = imfinfo(FileList{s});
%           dc = info.DigitalCamera;
%           T(s) = dc.ExposureTime;
%       end
%       tempImage = imread(FileList{s});
%       RED(:,:,s) = tempImage(:,:,1);
%       GREEN(:,:,s) = tempImage(:,:,2);
%       BLUE(:,:,s) = tempImage(:,:,3);
%   end

% Initial Setting.
  zMax = 255;
  zMin = 0;
  zMid = (zMax + zMin) * 0.5;
  intensityRange = 256;     % The range of intensity, which is 256.
  
  hdr = zeros(size(RED,1), size(RED,2), 3);
  
  Lamda = 100;
    
% Create the single weight matrix.
  for h = 1:256
      if (h-1) > zMid
          weight(h) = zMax - (h - 1);
      else
          weight(h) = (h - 1) - zMin;
      end      
  end
  
  
% Calculate the radiance.
% pixel{i}: A Nx2 matrix which records the pixels with intensity {i-1}
% points: A 256x3 matrix. The first two columns represent their locations,
% while the last column represents their intensity.
% weight: A matrix with the size of 256 which represents the weight of each
% intensity.
  for a = 1:3
      % Read in and process R, G, B separately.
      if a == 1
          colorImage = RED;
      elseif a ==2
          colorImage = GREEN;
      else
          colorImage = BLUE;
      end
      % Categorize pixels with different intensity into differeny groups.
      numPixel = 0;     % The total number of pixel that is going to be used in radiance.
      for b = 1:256
          [tempRow tempCol] = find(colorImage(:,:,round(size(colorImage,3)/2)) == b-1);
          if isempty(tempRow)
              trash = 0;
            %display(strcat(b,'empty'));
          else
              % Select a point to make sure its intensity in different
              % frame doesn't repeat.
              potentialPoints = [tempRow tempCol];
              %display(potentialPoints);
              % Randomly pick one point from "potentialPoints" and generate
              % weight matrix.
               % display(strcat(b,'NO'));
              %display(size(potentialPoints, 1));
              if (size(potentialPoints, 1) > 1)
                  numPixel = numPixel + 1
                  pixel{numPixel} = [tempRow tempCol]
                  pick = floor(rand * (size(potentialPoints,1) - 1)) + 1;
                  points(numPixel, :) = [potentialPoints(pick,1) potentialPoints(pick,2) (b-1)];
              end
              display(size(potentialPoints, 1));
          end
      end  
      display('srg done');
      numPixel
      
      % Generate the calculation matrices.
      A = zeros((numPixel*size(colorImage,3)) + 254 + 1, intensityRange + numPixel);
      B = zeros(size(A,1), 1);
      p = 0;
      for i = 1:numPixel
          for j = 1:size(colorImage,3)
              p = p + 1;
              A(p, colorImage(points(i,1), points(i,2), j) + 1) = weight(colorImage(points(i,1), points(i,2), j) + 1);
              A(p, intensityRange + i) = -weight(colorImage(points(i,1), points(i,2), j) + 1);
              B(p, 1) = weight(colorImage(points(i,1), points(i,2), j) + 1) * log(T(j));
              
          end
      end
      % Fill in the punishing terms.
      for d = (zMin + 1):(zMax - 1)
          A(numPixel*size(colorImage,3) + d, d) = Lamda * weight(d + 1);
          A(numPixel*size(colorImage,3) + d, d + 1) = -2 * Lamda * weight(d + 1);
          A(numPixel*size(colorImage,3) + d, d + 2) = Lamda * weight(d + 1);
      end
      % Add the constraint term to set the g(mid intensity) = 0
      A(end, (round(size(points,1)/2) + 1)) = 1;
      % Use SVD to solve the equation.
      X = A\B;
      G = X(1:intensityRange);
      lnE = X(intensityRange + 1:end);
      for q = 1:numPixel
          numerator = 0;
          denominator = 0;
          for r = 1:size(colorImage,3)
              denominator = denominator + weight(colorImage(points(q,1), points(q,2), r) + 1);
              numerator = numerator + weight(colorImage(points(q,1), points(q,2), r) + 1) * (G(colorImage(points(q,1), points(q,2), r) + 1) - log(T(r)));
          end
          lnE(q) = numerator/ denominator;
      end
      %display(lnE);
      E = exp(lnE);
      logE(:,a) = lnE;
      % Normalize the Z-mid radiance.
      E = E/E(128);
      for e = 1:numPixel
          group = pixel{e};
          for f = 1:size(group, 1)
              hdr(group(f,1), group(f,2), a) = E(e);
          end
      end
  end
  imshow(hdr)
  rgb = tonemap(hdr);
  imshow(rgb)
  

  
  
  
  
function [FileList] = dig(FilePath,FileList,FileExt,verbose)
dirList = dir(FilePath);
ridx = strcmp({dirList.name},'.') | strcmp({dirList.name},'..');
dirList(ridx) = [];
if size(dirList,2) ~= 0
    for listing = 1:size(dirList,1)
        current_Path = [FilePath dirList(listing).name];
        typed_path = regexprep(current_Path,'\','\\\');
        if verbose
            fprintf(['Looking at:' typed_path '\n']);
        end
        if dirList(listing).isdir
            FileList = dig([current_Path '\'],FileList,FileExt,verbose);
        else
            FileExt;
            dirList(listing).name(end-2:end);
            if any(strcmp(FileExt,dirList(listing).name(end-2:end)))
                FileList{end+1,1} = current_Path;
            end
        end
    end
end