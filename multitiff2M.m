function M = multitiff2M(tiff,framesel) % Create a function M
tiffinfo = imfinfo(tiff); % imfinfo of tiff gives you a structure array with one image of tiff in each field
% infos sur image, struct dont la taille est le nb de frames

numframes = length(tiffinfo); % Length just calculates the length of an array for example, here the length of your tiffinfo structure array that contains the frames of your tiff image
%nb de frames

M = zeros(tiffinfo(1).Height,tiffinfo(1).Width,['uint' num2str(tiffinfo(1).BitDepth)]);
for frame=framesel
    curframe = im2uint8(imread(tiff,frame));
    M(:,:,frame-framesel(1)+1) = curframe;
end


