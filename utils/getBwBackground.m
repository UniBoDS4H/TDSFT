function bg = getBwBackground(img)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 17, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: black and white image
% OUTPUT:
%       bg: background of the image (1 => white, 0 => black)
%  
% DESCRIPTION:
%       Returns the background of a black and white image.

    [r, c] = size(img);

    b1 = img(1, round(c/2));
    b2 = img(r, round(c/2));
    b3 = img(round(r/2), 1);
    b4 = img(round(r/2), c);

    bg = b1 && b2 && b3 && b4;
end