% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   May 8, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%       array containing the segmentations of which compute the mask.
%
% OUTPUT:
%   - mask(Matrix: [height, width]):
%       the mask of the segmentations.
%
%
% DESCRIPTION:
%  Mask of the segmentations used by the close line algorithms.
%  In order to obtain faster and more accurate segmentation results, is important to specify an initial
%  contour position that is close to the desired object boundaries. For that reason, we use as a mask the
%  largest segmentation area.
function mask = getSegmentationsMask(segmentations)
    mask = fusion_Largest(segmentations);
    mask = imfill(mask, "holes");
end