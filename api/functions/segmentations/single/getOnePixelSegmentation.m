% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - seg (Matrix [height, width]):
%       black and white segmentation.
%   - line (string):
%       the line to use if the segmentation is of more than one pixel
%       (see onePixelSegmentation.m for more details).
%
% OUTPUT:
%   - opSeg (Matrix [height, width]):
%       the one-pixel segmentation.
% 
% DESCRIPTION:
%   Gets the one-pixel segmentation. Often the line of the segmentation is not of one pixel, but of more.
%   If the segmentation is of more than one pixel, it is possible to get the external, internal, or middle line.
%   (see OnePixelLineTypes.m for more details)
function opSeg = getOnePixelSegmentation(seg, line)
    % Fill the holes.
    segFill = imfill(seg, "holes");

    % Get the one-pixel segmentation using the specified line type.
    switch line
        case "internal"
            extSeg = bwperim(segFill);
            opSeg = bwperim(seg) - extSeg;
        case "middle"
            opSeg = bwskel(seg);
            opSeg = imfill(opSeg, "holes");
            opSeg = bwperim(opSeg);
        % Default is external line.
        otherwise
            opSeg = bwperim(segFill);
    end
end