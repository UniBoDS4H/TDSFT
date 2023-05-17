% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 8, 2023
% NAME: TDSFT (version 1.0)
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

% DESCRIPTION:
%   Use the Shape-Preserving Piecewise Cubic Hermite interpolation (PCHIP) to
%   close the segmentation.
%
% REFERENCES:
%   ] Fritsch, F. N. and R. E. Carlson,
%   "Monotone Piecewise Cubic Interpolation",
%   SIAM Journal on Numerical Analysis. Vol. 17, 1980, pp.238–246.
function res = closing_ShapePreserving(fusionResult, inputSegmentations)
    res = closingWithInterpolation(fusionResult, inputSegmentations, "pchip");
end