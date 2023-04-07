function seg = getImgContour(img)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 20, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: black and white image.

% OUTPUT:
%       seg: the segmentation of the object.
% 
% DESCRIPTION:
%       Gets the segmentation of the object contained in the image.

% Fill the holes 
imgFill = imfill(img, 'holes');

% Get the external perimeter
seg = bwperim(imgFill);

% TODO: get the internal perimeter
% extSeg = bwperim(imgFill);
% seg = bw perim(imgFill) - extSeg;

end