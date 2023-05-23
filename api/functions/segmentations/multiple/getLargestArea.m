% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 12, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - overlappedSegmentations(Matrix: [height, width]:
%       the sum (overlap) of all the segmentations.
%
% OUTPUT:
%   - largestSegmentation(Matrix: [height, width]):
%       the perimeter of the total area covered by the segmentations.
%   - largestArea(Matrix: [height, width]):
%       the total area covered by the segmentations.
%
% DESCRIPTION:
%   Return the largest possible area (and its perimeter) as a matrix height * width.
%   The largest area is the total area covered by the segmentations.
function [area, perimeter] = getLargestArea(overlappedSegmentations) 

    % Binarize the overlapped segmentations.
    overlappedSegmentations = imbinarize(overlappedSegmentations);

    % Fill the resulting segmentation and get the perimeter.
    area = imfill(overlappedSegmentations, "holes");
    perimeter = bwperim(area);
end