% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: April 23, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentation (Matrix [height, width]):
%           the segmentation where to find the nearest pixel with value val
%       startRow (int):
%           the row (y coordinate) of the pixel from which to start the search
%       startCol (int):
%           the col (x coordinate) of the pixel from which to start the search
%
% OUTPUT:
%       row: the row (x coordinate) of the nearest non-zero pixel
%       col: the col (y coordinate) of the nearest non-zero pixel
%
% THROWS:
%       getNearestPixelWithValue:invalidIndex:
%           if the pixel index is out of bounds
%       getNearestPixelWithValue:noNonZeroPixel:
%           if no non-zero pixel is found
%
% DESCRIPTION:
%       Get the nearest non-zero pixel from the given pixel index.
function [row, col] = getNearestNonZeroPixel(segmentation, startRow, startCol, val)     
    [height, width] = size(segmentation);
    
    if startRow < 1 || startRow > height || startCol < 1 || startCol > width
        throw(MException('getNearestPixelWithValue:invalidIndex', 'Pixel index out of bounds'));
    end

    [~, nearestPixelArray] = bwdist(segmentation);
    nearestPixelLinearIndex = nearestPixelArray(startRow, startCol);

    if nearestPixelLinearIndex == 0
        throw(MException('getNearestPixelWithValue:noNonZeroPixel', 'No non-zero pixel found'));
    end

    [row, col] = ind2sub([height, width], nearestPixelLinearIndex);
end