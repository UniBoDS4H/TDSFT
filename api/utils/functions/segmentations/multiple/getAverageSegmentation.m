% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 23, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%       startSegmentation (Integer || Matrix: [height, width]):
%           the segmentation to start the fusion with.
%           It can be:
%           - an integer: it is the index of the segmentation to start the fusion with
%             (the segmentation from which to start is one of input);
%           - a matrix: it is the segmentation to start the fusion with.
%
% OUTPUT:
%       averageSeg(Matrix: [height, width]):
%           the average segmentation.
%
% THROWS:
%      TDSFT:algorithms:
%           if the input array `segmentations` is empty.
%
% DESCRIPTION:
%       The average segmentation is computed by averaging the segmentations as follows:
%       For each pixel with value 1 of the start segmentation is searched the closest pixel
%       with value 1 in the other segmentations. Then it is computed the average pixel:
%       - if the segmentations are 2, the average pixel is the middle point between the two pixels;
%       - if the segmentations are more than 2, the average pixel is the centroid of the pixels. 
function averageSeg = getAverageSegmentation(segmentations, startSegmentation) 
    if isempty(segmentations)
        throw(MException("TDSFT:algorithms", "Segmentations array empty"));
    end

    nSeg = length(segmentations);
    
    % If there is only one segmentation, return it
    if nSeg == 1
        smallestSegmentation = segmentations{1};
        return;
    end

    % Get the main segmentation
    % If startSegmentation is a number, get the segmentation from the array `segmentations`
    if isnumeric(startSegmentation)
        mainSeg = segmentations{startSegmentation};
    else
        mainSeg = startSegmentation;
    end

    % Get the size of the main segmentation
    [height, width] = size(mainSeg);

    % Create the output segmentation
    averageSeg = zeros(height, width);

    % For each pixel of the main segmentation
    try 
        for i = 1:height
            for j = 1:width

                % If the pixel is a 1 then search the nearest pixel in the other segmentations
                if mainSeg(i, j) == 1

                    % Create an array containing the nearest pixels of the other segmentations
                    % If the main segmentation is not inside `segmentations`, the length of the array
                    % is the number of segmentations + 1
                    arrayLength = nSeg;
                    if ~isnumeric(startSegmentation)
                        arrayLength = arrayLength + 1;
                    end
                    nearestPixels = zeros(arrayLength, 2);

                    idx = 1;

                    % Add the pixel of the main segmentation to the array
                    nearestPixels(idx, :) = [i, j];
                    idx = idx + 1;

                    for k = 1:nSeg
                        % If the segmentation is the start segmentation, skip it
                        if isnumeric(startSegmentation) && k == startSegmentation
                            continue;
                        end
                        % The index of the array is the index of the segmentation + 1 because the first
                        % element is the main segmentation pixel 
                        nearestPixels(idx, :) = getNearestNonZeroPixel(segmentations{k}, i, j);
                        idx = idx + 1;
                    end
                    % Get the centroid of the points
                    [row, col] = getCentroid(nearestPixels);    
                        
                    % Set the pixel to 1
                    averageSeg(row, col) = 1;
                end
            end
        end
    catch ME
        rethrow(ME);
    end
end