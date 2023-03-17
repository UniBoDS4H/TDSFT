function contour = getImgContour(grayImg)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 15, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       grayImg: a grayscale image

% OUTPUT:
%       cImg: the external contour of the image

% Convert to black and white image
bwImg = imbinarize(grayImg);

% Get the perimeter
perim = bwperim(bwImg);

% Compute external contour
perimFill = imfill(perim, 'holes');
inner = perimFill - perim;
dil = imdilate(dif1, strel('sphere', 1));
contour = dil - inner;

end