% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 23, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%       array containing the segmentations to fuse.
%   - target (Integer || Matrix: [height, width]):
%       the target segmentation from which the average is computed.
%       It can be:
%         - integer: the index of one of the input segmentations;
%         - matrix:  the segmentation to start the fusion with.
%
% OUTPUT:
%   - averageSeg (Matrix: [height, width]):
%       the average segmentation.
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the input array 'segmentations' is empty.
%
% DESCRIPTION:
%  The average segmentation is computed by averaging the segmentations as follows:
%  For each pixel with value 1 of the target segmentation is searched for the closest pixel
%  with value 1 in the other segmentations. Then it is computed the average pixel:
%  - if the segmentations are 2, the average pixel is the middle point between the two pixels;
%  - if the segmentations are more than 2, the average pixel is the centroid of the pixels. 
function averageSeg = getAverageSegmentation(segmentations, target) 
    if isempty(segmentations)
        throw(MException("TDSFT:fusionProcess", "Segmentations array empty"));
    end

    % Number of input segmentations.
    nSeg = length(segmentations);
    
    
    % If there is only one segmentation, return it.
    if nSeg == 1
        averageSeg = segmentations{1};
        return;
    end
    
    % Number of segmentations to consider in the average process.
    % If startSegmentation is a number, the number of segmentations is the length of the input array.
    % Else, the number of segmentations is the length of the input array + 1.   
    arrayLength = nSeg;
    
    % Get the main segmentation.
    % If startSegmentation is a number, get the segmentation from the array 'segmentations'.
    if isnumeric(target)
        mainSeg = segmentations{target};
    else
        mainSeg = target;
        arrayLength = arrayLength + 1;
    end

    % Get the size of the main segmentation.
    [height, width] = size(mainSeg);

    % Preallocate the output segmentation matrix.
    averageSeg = zeros(height, width);

    % For each pixel of the main segmentation.
    try 
        for i = 1:height
            for j = 1:width
                % If the pixel value is 1 then, for every other segmentation, search for the nearest pixel.
                if mainSeg(i, j) == 1

                    % Array containing the pixel himself and the nearest pixels of the other segmentations.
                    nearestPixels = zeros(arrayLength, 2);
                    % Current index of the nearestPixels array.
                    idx = 1;
                    % Add the pixel of the main segmentation to the array.
                    nearestPixels(idx, :) = [i, j];
                    idx = idx + 1;

                    for k = 1:nSeg
                        % If the segmentation is the start segmentation, skip it.
                        if isnumeric(target) && k == target
                            continue;
                        end
                        % The index of the array is the index of the segmentation + 1 because the first
                        % element is the main segmentation pixel.
                        [row, col] = getNearestNonZeroPixel(segmentations{k}, i, j);
                        nearestPixels(idx, :) = [row, col];
                        idx = idx + 1;
                    end
                   
                    % Get the centroid of the points.
                    [row, col] = getCentroid(nearestPixels);    
                        
                    % Set the pixel to 1.
                    averageSeg(row, col) = 1;
                end
            end
        end
    catch ME
        rethrow(ME);
    end
end