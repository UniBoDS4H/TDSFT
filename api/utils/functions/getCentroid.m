function [x, y] = getCentroid(points) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: April 20, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       points (one-dimensional array of pairs of integers:
    %           the points used to compute the centroid
    %
    % OUTPUT:
    %       x: the x coordinate of the centroid
    %       y: the y coordinate of the centroid
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

    if length(points) == 0
        throw (MException('getCentroid:emptyPoints', 'The points array is empty'));
    end
    
    if length(points) == 1
        x = points(1, 1);
        y = points(1, 2);
        return;
    end

    % not using (a+b)/2 because it could overflow
    if size(points, 1) == 2
        x = points(1, 1) + ( points(2, 1) - points(1, 1)) / 2;
        y = points(1, 2) + ( points(2, 2)- points(1, 2)) / 2;
        return;
    end

    pgon = polyshape(points);
    [x, y] = centroid(pgon);
end