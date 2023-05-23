% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   May 8, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations(Cell array: [1, nSeg] (Cells: matrix [height, width]):
%       the segmentations to fill.
%
% OUTPUT:
%   - filledSegmentations(Cell array: [1, nSeg] (Cells: matrix [height, width]):
%       the filled input segmentations.
%
% DESCRIPTION:
%   Fill (make dense) all the input segmentations.
function filledSegmentations = getFilledSegmentations(segmentations)
    % Preallocate the output.
    filledSegmentations = cell(1, length(segmentations));
    for i = 1:length(segmentations)
        filledSegmentations{i} = imfill(segmentations{i}, "holes");
    end
end