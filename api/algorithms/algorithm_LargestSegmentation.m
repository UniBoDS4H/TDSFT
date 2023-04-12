function largestSegmentation = algorithm_LargestSegmentation(segmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
    %           the segmentations to fuse.
    %
    % THROWS:
    %       largestSegmentations:emptyInput (Exception):
    %           throwed if the input is empty.
    %
    % OUTPUT:
    %       largestSegmentation (Matrix [height, width]):
    %           the largest segmentation.
    %
    % DESCRIPTION:
    %       Fuse all the segmentations together overlapping them and getting the largest possible segmentation.
    %       The largest segmentation is the smallest segmentation possible which contains each input segmentation.
    %       To obtain it the segmentations are overlapped and then is returned the perimeter of the area covered by them.

    disp('Getting the largest segmentation...');

    % Check if the input is empty
    if isempty(segmentations)
        ME = MException('largestSegmentation:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    % If there is only one segmentation, return it
    if length(segmentations) == 1
        largestSegmentation = segmentations{1};
        return;
    end

    % get the largest segmentation
    overlap = overlapSegmentations(segmentations);
    largestSegmentation = getLargestSegmentation(overlap);
end