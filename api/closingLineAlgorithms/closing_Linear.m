% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   May 17, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - fusionResult (Matrix [height, width]):
%       the result of the fusion process.
%       It is a not-close segmentation that needs to be closed.
%   - inputSegmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%       the segmentations used for the fusion process.
%
% OUTPUT:
%   - res (Matrix: [height, width]):
%       the resulting segmentation after the closing process.
%
% DESCRIPTION:
%   Use the Linear interpolation to close the fusion result.
function res = closing_Linear(fusionResult, inputSegmentations)
    res = closingWithInterpolation(fusionResult, inputSegmentations, "linear");
end