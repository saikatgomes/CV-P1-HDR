function [ ] = hdrtest()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


% files = {'../Images/MemorialTest/memorial0061.png', '../Images/Memorial/memorial0065.png',...
%     '../Images/Memorial/memorial0070.png'};
% expTimes = [1/0.03125, 1/0.5,1/16];

% files = {'../Images/Memorial/memorial0061.png', '../Images/Memorial/memorial0062.png', ...
%     '../Images/Memorial/memorial0063.png', '../Images/Memorial/memorial0064.png', ...
%     '../Images/Memorial/memorial0065.png', '../Images/Memorial/memorial0066.png', ...
%     '../Images/Memorial/memorial0067.png', '../Images/Memorial/memorial0068.png', ...
%     '../Images/Memorial/memorial0069.png', '../Images/Memorial/memorial0070.png', ...
%     '../Images/Memorial/memorial0071.png', '../Images/Memorial/memorial0072.png', ...
%     '../Images/Memorial/memorial0073.png', '../Images/Memorial/memorial0074.png', ...
%     '../Images/Memorial/memorial0075.png', '../Images/Memorial/memorial0076.png'};
% expTimes = [1/0.03125,1/0.0625, 1/0.125, 1/0.25, 1/0.5, 1, 1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024];

% files = {'../Img/Memorial/memorial0061.png', '../Img/Memorial/memorial0062.png', ...
%     '../Img/Memorial/memorial0063.png', '../Img/Memorial/memorial0064.png', ...
%     '../Img/Memorial/memorial0065.png', '../Img/Memorial/memorial0066.png', ...
%     '../Img/Memorial/memorial0067.png', '../Img/Memorial/memorial0068.png', ...
%     '../Img/Memorial/memorial0069.png', '../Img/Memorial/memorial0070.png', ...
%     '../Img/Memorial/memorial0071.png', '../Img/Memorial/memorial0072.png', ...
%     '../Img/Memorial/memorial0073.png', '../Img/Memorial/memorial0074.png', ...
%     '../Img/Memorial/memorial0075.png', '../Img/Memorial/memorial0076.png'};
% expTimes = [1/0.03125,1/0.0625, 1/0.125, 1/0.25, 1/0.5, 1, 1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024];

files = {'../Images/museumHDR/IMG_9495.jpg', '../Images/museumHDR/IMG_9496.jpg', ...
    '../Images/museumHDR/IMG_9497.jpg'};
expTimes = [1/4,1/1.6,1];

hdr = makehdr(files);

%hdr = makehdr(files, 'ExposureValues', expTimes );
% %hdr = makehdr(files, 'RelativeExposure', expTimes ./ expTimes(1));
rgb = tonemap(hdr);
figure; imshow(rgb);
figure; imshow(hdr);

end

