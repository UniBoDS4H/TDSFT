% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       seg (Matrix [height, width]):
%           black and white segmentation.
%       internal (boolean):
%           if true (1), is used the internal line (when the segmentation is of more than one pixel).    
%
% OUTPUT:
%       opSeg (Matrix [height, width]):
%           the one-pixel segmentation.
% 
% DESCRIPTION:
%       Gets the one-pixel segmentation. Often the line of the segmentation is not one pixel, but more.
%       If the segmentation is of more than one pixel, it is possible to get the internal or external line.
function opSeg = getOnePixelSegmentation(seg, internal)
    % Fill the holes 
    segFill = imfill(seg, 'holes');

    % Get the internal perimeter
    if internal
        extSeg = bwperim(segFill);
        opSeg = bwperim(seg) - extSeg;

    % Get the external perimeter
    else
        opSeg = bwperim(segFill);
    end
end