% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 12, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, nSeg] (Cells: matrix [height, width]):
%       the segmentations to overlap.
%
% OUTPUT:
%   - overlap (Matrix [height, width]):
%       the overlapped segmentations.
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the input is empty.
%
% DESCRIPTION:
%   Overlap (sum) the input segmentations and return the resulting matrix.  
function overlap = overlapSegmentations(segmentations)     
    % Check if the input is empty.
    if isempty(segmentations)
        throw(MException("TDSFT:fusionProcess", "Segmentations array empty"));
    end

    % If there is only one segmentation, return it.
    if length(segmentations) == 1
        overlap = segmentations{1};
        return;
    end

    % Initialize the overlap.
    [height, width] = size(segmentations{1});
    overlap = zeros(height, width, "uint8");

    % Overlap all the segmentations.
    for i=1:length(segmentations)
        seg = uint8(segmentations{i});
        overlap = overlap + seg;
    end 
end