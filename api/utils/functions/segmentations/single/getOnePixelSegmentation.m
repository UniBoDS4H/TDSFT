% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       seg (Matrix [height, width]):
%           black and white segmentation.
%       internal (boolean):
%           if true (1), is used the internal line (when the segmentation is of more than one pixel). 
%       middle (boolean):
%           if true (1), is used the middle line (when the segmentation is of more than one pixel). 
%
% OUTPUT:
%       opSeg (Matrix [height, width]):
%           the one-pixel segmentation.
%
% THROWS:
%       MException:processImage
%           if internal and middle are both true (1).
% 
% DESCRIPTION:
%       Gets the one-pixel segmentation. Often the line of the segmentation is not one pixel, but more.
%       If the segmentation is of more than one pixel, it is possible to get the external, internal or middle line.
%       The external line is the default one.
%       ATTENTION: Cannot be used both internal and middle line.
function opSeg = getOnePixelSegmentation(seg, internal, middle)
    % Check the input
    if internal && middle
        throw(MException("TDSFT:processImage", "Cannot be used both internal and middle line"));
    end

    % Fill the holes 
    segFill = imfill(seg, "holes");

    % Get the internal perimeter
    if internal
        extSeg = bwperim(segFill);
        opSeg = bwperim(seg) - extSeg;

    % Get the middle perimeter
    elseif middle
        opSeg = bwskel(seg);
        opSeg = imfill(opSeg, "holes");
        opSeg = bwperim(opSeg);

    % Get the external perimeter (default)
    else
        opSeg = bwperim(segFill);
    end
end