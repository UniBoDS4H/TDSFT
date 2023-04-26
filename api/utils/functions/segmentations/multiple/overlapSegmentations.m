% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations (Cell array: [1, nSeg] (Cells: matrix [height, width]):
%           the segmentations to overlap.
%
% OUTPUT:
%       overlap (Matrix [height, width]):
%           the overlapped segmentations.
%
% THROWS:
%       overlapSegmentations:emptyInput (Exception):
%           throwed if the input is empty.
%
% DESCRIPTION:
%       Overlap (sum) the input segmentations and return the resulting matrix.  
function overlap = overlapSegmentations(segmentations)     
    % check if the input is empty
    if isempty(segmentations)
        ME = MException('overlapSegmentations:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    % if there is only one segmentation, return it
    if length(segmentations) == 1
        res = segmentations{1};
        return;
    end

    % initialize the overlap
    [height, width] = size(segmentations{1});
    overlap = zeros(height, width, 'uint8');

    % overlap all the segmentations
    for i=1:length(segmentations)
        seg = uint8(segmentations{i});
        overlap = overlap + seg;
    end 
end