% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 8, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   fusionResult (Matrix [height, width]):
%     the result of the fusion process.
%     It is a not-close segmentation which needs to be closed.
%   inputSegmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%     the segmentations used for the fusion process.
%
% OUTPUT:
%   res (Matrix: [height, width]):
%     the resulting segmentation after the closing process.

% DESCRIPTION:
%   Use Chan-Vese algorithm to close a result of the fusion process which is not closed.
%   Use the input segmentations to get the nearest mask to the border.
%
%   The Chan-Vese algorithm is a level set method which differ from classial snake and active contour methods
%   because it does not require a stopping edge-function.It is a model which can detect contours both with or
%   without gradient, for instance objects with very smooth boundaries or even with discontinuous boundaries
%
% REFERENCES:
%   T. F. Chan and L. A. Vese, 
%   "Active contours without edges,"
%   in IEEE Transactions on Image Processing, 
%   vol. 10, no. 2, pp. 266-277, Feb. 2001, doi: 10.1109/83.902291.
function res = close_ChanVese(fusionResult, inputSegmentations)
    mask = getSegmentationsMask(inputSegmentations);
    nIterations = 3000;
    smoothfactor = 0.6;
    incrementFactor = 25;
    res = activecontour(fusionResult .* incrementFactor, mask, nIterations, "chan-vese", "SmoothFactor", smoothfactor);
    res = imfill(res, "holes");
    res = bwperim(res);
end