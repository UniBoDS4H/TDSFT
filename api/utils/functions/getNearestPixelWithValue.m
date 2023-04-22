% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: April 20, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentation (Matrix [height, width]):
%           the segmentation where to find the nearest pixel with value val
%       startX (int):
%           the x coordinate of the pixel from which to start the search
%       startY (int):
%           the y coordinate of the pixel from which to start the search
%       val (int):
%           the value to search for
%
% OUTPUT:
%       x: the x coordinate of the nearest pixel
%       y: the y coordinate of the nearest pixel
%
% THROWS:
%       getNearestPixelWithValue:invalidIndex:
%           if the pixel index is out of bounds
%
% DESCRIPTION:
%       Get the centroid of a set of points.
%       If the number of points is 1, the centroid is the point itself.
%       If the number of points is 2, the centroid is the middle point.
%       If the number of points is >= 3, use the centroid matlab built-in function.
function [x, y] = getNearestPixelWithValue(segmentation, startX, startY, val)     
    [height, width] = size(segmentation);
    if startX < 1 || startX > width || startY < 1 || j > height
        throw(MException('getNearestPixelWithValue:invalidIndex', 'Pixel index out of bounds'));
    end

    % add the starting pixel to the queue
    x = startX;
    y = startY;
    q = Queue;
    enqueue(q, x, y);

    % initialize the visited matrix
    visited = zeros(height, width);

    % loop until the queue is empty
    while ~isEmpty(q)

        [x, y] = dequeue(q);
        visited(x, y) = 1;
        
        % when the pixel is found, return it
        if segmentation(x, y) == val
            return;
        end

        % iterate over the 8 neighbors
        for i = -1:1
            for j = -1:1
                % if the neighbor is not the current pixel and is not out of bounds
                if ( i ~= 0 || j ~= ) 0 && x + i >= 1 && x + i <= width && y + j >= 1 && y + j <= height
                    
                    % if the neighbor is not visited
                    if ~visited(x + i, y + j)
                        % add the neighbor to the queue
                        enqueue(q, x + i, y + j);
                    end
                end
            end
        end
    end

    % if the pixel is not found, throw an exception
    throw(MException('getNearestPixelWithValue:valueNotFound', 'Value not found in segmentation'));

end