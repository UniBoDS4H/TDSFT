% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 23, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentation (Matrix [height, width]):
%       the segmentation where to find the nearest non-zero pixel.
%   - startRow (int):
%       the row (y coordinate) of the pixel from which to start the search.
%   - startCol (int):
%       the col (x coordinate) of the pixel from which to start the search.
%
% OUTPUT:
%   - row (int):
%       the row (x coordinate) of the nearest non-zero pixel.
%   - col (int):
%       the col (y coordinate) of the nearest non-zero pixel.
%
% THROWS:
%   'TDSFT:fusionProcess':
%     if the pixel index is out of bounds.
%   'TDSFT:fusionProcess':
%     if no non-zero pixel is found.
%
% DESCRIPTION:
%   Get the nearest non-zero pixel from the given pixel index.
function [row, col] = getNearestNonZeroPixel(segmentation, startRow, startCol)     
    [height, width] = size(segmentation);
    
    %Check if the pixel index is out of bounds.
    if startRow < 1 || startRow > height || startCol < 1 || startCol > width
        throw(MException("TDSFT:fusionProcess", "Pixel index out of bounds"));
    end

    % If the pixel is already non-zero, return it.
    if segmentation(startRow, startCol) ~= 0
        row = startRow;
        col = startCol;
        return;
    end

    % Use the bwdist function to get the nearest non-zero pixel.
    [~, nearestPixelArray] = bwdist(segmentation);

    % Get the linear index of the nearest non-zero pixel.
    nearestPixelLinearIndex = nearestPixelArray(startRow, startCol);

    % Check if no non-zero pixel is found.
    if nearestPixelLinearIndex == 0
        throw(MException("TDSFT:fusionProcess", "No non-zero pixel found"));
    end

    % Convert the linear index to the row and col index.
    [row, col] = ind2sub([height, width], nearestPixelLinearIndex);
end