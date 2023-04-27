% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: April 11, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       overlap: the overlap between the binary segmentations
%       nSeg: the number of segmentations
%
% OUTPUT:
%       seg: the segmentation of the common area
%       area: the common area between all the segmentations
%
% DESCRIPTION:
%       Get the common area between all the segmentations.
%       The common area is the area selected by all the segmentations.
%       The common area is computed getting the pixel where value == number of segmentations.
function [seg, area] = getCommonArea(overlap, nSeg) 
    area = overlap;
    [m, n] = size(overlap);

    for i = 1:m
        for j = 1:n
            if area(i,j) == nSeg
                area(i,j) = 1;
            else
                area(i,j) = 0;
            end
        end
    end

    seg = bwperim(area);

end