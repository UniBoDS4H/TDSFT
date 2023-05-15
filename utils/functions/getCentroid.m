% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - points (one-dimensional array of integers pairs, [numPoints, 2]):
%       the points used to compute the centroid
%
% OUTPUT:
%   - row (int): 
%       the row (y coordinate) of the centroid
%   - col (int):
%       the col (x coordinate) of the centroid
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the points array is empty
%
% DESCRIPTION:
%   Get the centroid of a set of points.
%   If the number of points is 1, the centroid is the point itself.
%   If the number of points is 2, the centroid is the middle point.
%   If the number of points is >= 3, use the centroid Matlab built-in function
%   (if the points are collinear is computed the middle point of the segment between
%   the two extreme points).
function [row, col] = getCentroid(points)
    if isempty(points)
        throw (MException("TDSFT:fusionProcess", "The points array is empty"));
    end

    % Remove duplicates.
    points = unique(points, "rows");
    
    if size(points, 1) == 1
        row = points(1, 1);
        col = points(1, 2);
    % Not using (a+b)/2 because it could overflow.
    elseif size(points, 1) == 2
        [row, col] = getSegmentMiddlePoint(points);
    else
        pgon = polyshape(points, "KeepCollinearPoints", true);

        % Check if the points are collinear.
        if isequal(area(pgon), 0)
            [row, col] = getSegmentMiddlePoint(points);
        else    
            [row, col] = centroid(pgon);
        end
    end

    % Round the coordinates to the nearest integer.
    row = round(row);
    col = round(col);
end