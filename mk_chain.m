function [chain] = mk_chain(image_path)
% mk_chain Generate an 8 connected chain from an image 
%   
% input: an image path - should contain a single connected contour
% output: [Nx2] 8 connected chain of N coordinates
%

image = imread(image_path);
image = image(:,:,1);

%get first connected component
[start_r,start_c] = find(image,1,'first');

%as bwtraceboundary needs an intial direction, choose the 
%first one that works
if image(start_r+1,start_c+1) == 255
    dir = 'SE';
elseif image(start_r,start_c+1) == 255
    dir = 'E';
elseif image(start_r-1,start_c+1) == 255
    dir = 'NE';
elseif image(start_r-1,start_c) == 255
    dir = 'N';
elseif image(start_r-1,start_c-1) == 255
    dir = 'NW';
elseif image(start_r,start_c-1) == 255
    dir = 'W';
elseif image(start_r+1,start_c-1) == 255
    dir = 'SW';
elseif image(start_r+1,start_c) == 255
    dir = 'S';
else
    assert(0);
end

chain = bwtraceboundary(image,[start_r,start_c],dir);
    
