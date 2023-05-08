% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: April 27, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   points (one-dimensional array of pairs of integers, [numPoints, 2]):
%     the collinear points from which the middle point is computed
%
% OUTPUT:
%   row (int):
%     the row (y coordinate) of the middle point
%   col (int):
%     the col (x coordinate) of the middle point
%
% THROWS:
%   TDSFT:algorithms:
%     if the points array is empty
%
% DESCRIPTION:
%   Get the middle point of a set of collinear points.
%   If there are more than 2 points, the middle point is computed as the 
%   middle point between the two extreme points. 
function [x, y] = getMiddlePoint(points)
   
    if length(points) < 2
        throw(MException("TDSFT:algorithms", "Insert at least 2 points"));
    end

    % If there are more than 2 points search for the extreme points.
    if length(points) > 2
        extremePoints = zeros(2,2);
        [~, minIdx] = min(points(:,1));
        [~, maxIdx ] = max(points(:,1));
        extremePoints(1, :) = points(minIdx, :);
        extremePoints(2, :) = points(maxIdx, :);

    else
        extremePoints = points;
    end

    x = extremePoints(1,1) + ( extremePoints(2,1) - points(1, 1) ) / 2;
    y = extremePoints(1,2) + ( extremePoints(2,2) - points(1, 2) ) / 2;
end