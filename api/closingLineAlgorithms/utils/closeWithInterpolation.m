% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 17, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - fusionResult (Matrix [height, width]):
%       the result of the fusion process.
%       It is a not-close segmentation that needs to be closed.
%   - inputSegmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%       the segmentations used for the fusion process.
%   - method (String):
%       the interpolation method to use
%       (see the available methods here https://www.mathworks.com/help/matlab/ref/interp1.html#btwp6lt-1-method).
%
% OUTPUT:
%   - res (Matrix: [height, width]):
%       the resulting segmentation after the closing process.

% DESCRIPTION:
%   Convert the coordinates to polar coordinates, sort them by angular position
%   and use the specified interpolation method to interpolate the missing pixels.
function res = closeWithInterpolation(fusionResult, inputSegmentations, method)
    % Get the centroid of the largest segmentation.
    largest = fusion_Largest(inputSegmentations);
    cn = regionprops(largest, "Centroid").Centroid; % centroid
    s = size(fusionResult);

    % Find locations of outline pixels.
    [idxy, idxx] = find(fusionResult); % in cart coord
    [idxth, idxr] = cart2pol(idxx-cn(1), idxy-cn(2)); % in polar coord (theta, rho)

    % Sort pixel locations by angular position with reference to largest segmentation center center
    [idxth, sortmap] = sort(idxth, "ascend");
    idxr = idxr(sortmap);

    % Query points for interpolation.
    nQueryPoints = 100000;
    newth = linspace(-pi, pi, nQueryPoints).';

    %  Shape-Preserving Piecewise Cubic Hermite interpolation (PCHIP).
    newr = interp1(idxth, idxr, newth, method);

    % Remove NaNs, interpolation method produce NaNs for query points outside the domain.
    nanp = ~isnan(newr);
    newr = newr(nanp);
    newth = newth(nanp);

    % Construct output image.
    [newx, newy] = pol2cart(newth,newr);
    res = false(s);
    res(sub2ind(s, round(newy + cn(2)), round(newx + cn(1)))) = true;    

    % Fill holes and get the perimeter to remove interior pixels.
    res = imfill(res, "holes");
    res = bwperim(res);
end