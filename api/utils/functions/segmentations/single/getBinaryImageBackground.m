% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   img (Matrix [height, width]):
%     a black and white image.
%
% OUTPUT:
%   bg (int):
%     get the background of a black and white image.
%     1 if the background is white, 0 otherwise.
%  
% DESCRIPTION:
%   Returns the background color of a binary black and white image.
function bg = getBinaryImageBackground(img)
    [h, w] = size(img);

    % Get the sum of the first and last row and column.
    firstRow = sum( img(1, :) );
    lastRow = sum( img(h, :) );
    firstCol = sum( img(:, 1) );
    lastCol = sum( img(:, w) );

    % Since objects can't touch the border, if they are all 0, the background is white.
    bg = firstRow || lastRow || firstCol || lastCol;
end