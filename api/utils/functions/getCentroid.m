% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       points (one-dimensional array of pairs of integers, [numPoints, 2]):
%           the points used to compute the centroid
%
% OUTPUT:
%       row: the row (y coordinate) of the centroid
%       col: the col (x coordinate) of the centroid
%
% THROWS:
%       MException('getCentroid:emptyPoints', 'The points array is empty'):
%           if the points array is empty
%
% DESCRIPTION:
%       Get the centroid of a set of points.
%       If the number of points is 1, the centroid is the point itself.
%       If the number of points is 2, the centroid is the middle point.
%       If the number of points is >= 3, use the centroid matlab built-in function.
function [row, col] = getCentroid(points)
    if length(points) == 0
        throw (MException('getCentroid:emptyPoints', 'The points array is empty'));
    end

    % Remove duplicates
    points = unique(points, 'rows');
    
    if size(points, 1) == 1
        row = points(1, 1);
        col = points(1, 2);
    % not using (a+b)/2 because it could overflow
    elseif size(points, 1) == 2
        [row, col] = getMiddlePoint(points);
    else
        pgon = polyshape(points, 'KeepCollinearPoints', true);

        % Check if the points are collinear
        if isequal(area(pgon), 0)
            [row, col] = getMiddlePoint(points);
        else    
            [row, col] = centroid(pgon);
        end
    end
    row = round(row);
    col = round(col);
end