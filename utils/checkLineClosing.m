function check = checkLineClosing(img)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 17, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: a black and white image

% OUTPUT:
%       1 => Line closed - 0 => Line opened
% 

    imgFill = imfill(img,'holes');
    dif1 = imgFill - img;
    check =  sum(sum(dif1)) ~= 0;

end