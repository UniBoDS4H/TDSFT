% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img (Matrix [height, width]):
%           black and white image
% OUTPUT:
%       check: 
%           true (1) => white
%           false (0) => black)
%  
% DESCRIPTION:
%       Returns the background of a black and white image.
function check = isWhiteBackground(img)
        [h, w] = size(img);

        firstRow = sum( img(1, :) );
        lastRow = sum( img(h, :) );
        firstCol = sum( img(:, 1) );
        lastCol = sum( img(:, w) );

        check = firstRow || lastRow || firstCol || lastCol;
end