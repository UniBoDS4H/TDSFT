% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
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
%   Use Geodesic Active Contour algorithm to close a result of the fusion process which is not closed.
%   Use the input segmentations to get the nearest mask to the border.
%
%   This technique is based on active contours evolving in time according to intrinsic geometric measures of the image.
%   The evolving contours naturally split and merge, allowing the simultaneous detection of several objects and both interior 
%   and exterior boundaries. The proposed approach is based on the relation between active contours and the computation of geodesics
%   or minimal distance curves.
%
% REFERENCES:
%   Caselles, V., Kimmel, R. & Sapiro, G. Geodesic Active Contours.
%   International Journal of Computer Vision 22, 61–79 (1997).
function res = close_GeodesicActiveContour(fusionResult, inputSegmentations)
    mask = getSegmentationsMask(inputSegmentations);
    incrementFactor = 25;
    res = activecontour(fusionResult .* incrementFactor, mask, "edge");
    res = imfill(res, "holes");
    res = bwperim(res);
end