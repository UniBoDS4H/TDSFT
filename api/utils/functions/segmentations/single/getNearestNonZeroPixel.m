% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: April 23, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentation (Matrix [height, width]):
%           the segmentation where to find the nearest non-zero pixel
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
%       TDSFT:algorithms:
%           if the pixel index is out of bounds
%       TDSFT:algorithms:
%           if no non-zero pixel is found
%
% DESCRIPTION:
%       Get the nearest non-zero pixel from the given pixel index.
function [row, col] = getNearestNonZeroPixel(segmentation, startRow, startCol, val)     
    [height, width] = size(segmentation);
    
    if startRow < 1 || startRow > height || startCol < 1 || startCol > width
        throw(MException("TDSFT:algorithms", "Pixel index out of bounds"));
    end

    % If the pixel is already non-zero, return it
    if segmentation(startRow, startCol) ~= 0
        row = startRow;
        col = startCol;
        return;
    end

    [~, nearestPixelArray] = bwdist(segmentation);
    nearestPixelLinearIndex = nearestPixelArray(startRow, startCol);

    if nearestPixelLinearIndex == 0
        throw(MException("TDSFT:algorithms", "No non-zero pixel found"));
    end

    [row, col] = ind2sub([height, width], nearestPixelLinearIndex);
end