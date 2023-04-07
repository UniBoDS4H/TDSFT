function segLine = getSegmentation(seg, internal)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 20, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       seg: black and white segmentation.
%       internal: if true, the internal line is used (when segmentation of more than one pixel).    

% OUTPUT:
%       segLine: the one-pixel segmentation.
% 
% DESCRIPTION:
%       Gets the one-pixel segmentation.

% Fill the holes 
segFill = imfill(seg, 'holes');
% Get the internal perimeter
if internal
    disp("ciao");
    extSeg = bwperim(segFill);
    segLine = bwperim(seg) - extSeg;
% Get the external perimeter
else
    segLine = bwperim(segFill);
end


end