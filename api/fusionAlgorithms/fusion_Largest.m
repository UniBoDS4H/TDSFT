% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, raters], Cells: matrix [height, width] || Matrix [height, width]):
%       - array (Cell array: [1, raters], Cells: matrix [height, width]): 
%           array containing the segmentations to fuse;
%       - matrix (Matrix [height, width]):
%           the segmentations are already overlapped in a matrix.
%           (The algorithm need NO dense segmentations, so to overlap the segmentations do not have to fill the holes)
%
% OUTPUT:
%   - largestSegmentation (Matrix [height, width]):
%       the largest segmentation.
%
% DESCRIPTION:
%   Fuse all the segmentations together overlapping them and getting the largest possible segmentation.
%   The largest segmentation is the smallest segmentation possible which contains each input segmentation.
%   To obtain it, first the segmentations are overlapped and then it is returned the perimeter of the total
%   area covered by them.
function largestSegmentation = fusion_Largest(segmentations) 
    if iscell(segmentations)
        overlap = overlapSegmentations(segmentations);
    else 
        overlap = segmentations;
    end

    [~, largestSegmentation] = getLargestArea(overlap);
end