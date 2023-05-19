% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 11, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - overlap(Matrix: [height, width]:
%       the overlap between the binary filled segmentations.
%   - nSeg(int):
%       the number of segmentations.
%
% OUTPUT:
%   - seg((Matrix: [height, width]):
%       the segmentation of the common area.
%   - area:
%       the common area between all the segmentations.
%
% DESCRIPTION:
%   Get the common area between all the segmentations.
%   The common area is the area covered by all the segmentations.
function [area, perimeter] = getCommonArea(overlap, nSeg) 
    area = overlap;
    [m, n] = size(overlap);

    % If the pixel is covered by all the segmentations, it is set to 1.
    for i = 1:m
        for j = 1:n
            if area(i,j) == nSeg
                area(i,j) = 1;
            else
                area(i,j) = 0;
            end
        end
    end

    perimeter = bwperim(area);
end