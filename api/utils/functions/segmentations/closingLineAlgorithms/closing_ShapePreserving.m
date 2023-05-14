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
%   Use the Shape-Preserving Piecewise Cubic Hermite interpolation (PCHIP).
%   It gets the polar coordinates of the outline pixels of the fusion result
%   and then it interpolates them with the PCHIP method.
%
% REFERENCES:
%   ] Fritsch, F. N. and R. E. Carlson,
%   "Monotone Piecewise Cubic Interpolation.",
%   SIAM Journal on Numerical Analysis. Vol. 17, 1980, pp.238–246.
function res = closing_ShapePreserving(fusionResult, inputSegmentations)
    % get the centroid of the largest segmentation
    largest = algorithm_Largest(inputSegmentations);
    cn = regionprops(largest, "Centroid").Centroid;
    s = size(fusionResult);

    % find locations of outline pixels
    [idxy, idxx] = find(fusionResult); % in cart coord
    [idxth, idxr] = cart2pol(idxx-cn(1),idxy-cn(2)); % in polar coord (theta, rho)

    % sort pixel locations by angular position with reference to largest segmentation center center
    [idxth, sortmap] = sort(idxth,"ascend");
    idxr = idxr(sortmap);

    % query points for interpolation
    nQueryPoints = 100000;
    newth = linspace(-pi, pi, nQueryPoints).';

    %  Shape-Preserving Piecewise Cubic Hermite interpolation (PCHIP)
    newr = interp1(idxth,idxr,newth,"pchip");

    % remove NaNs, interpolation method produce NaNs for
    % query points outside the domain
    nanp = ~isnan(newr);
    newr = newr(nanp);
    newth = newth(nanp);

    % construct output image
    [newx, newy] = pol2cart(newth,newr);
    res = false(s);
    res(sub2ind(s,round(newy+cn(2)),round(newx+cn(1)))) = true;    

    % fill holes and get perimeter to remove interior pixels
    res = imfill(res, 'holes');
    res = bwperim(res);
end