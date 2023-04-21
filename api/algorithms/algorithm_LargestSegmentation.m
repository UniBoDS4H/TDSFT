function largestSegmentation = algorithm_LargestSegmentation(segmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 20, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       The function accepts two different input parameters:
    %
    %       1) segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
    %           the cell array containing the segmentations to fuse.
    %
    %       2) segmentations (Matrix [height, width]):
    %           the segmentations are already overlapped in a matrix.
    %           To overlap the segmentations must NOT be filled (the algorithm need NO dense segmentations).
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

    if iscell(segmentations)

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
    else 
        overlap = segmentations;
    end
    largestSegmentation = getLargestSegmentation(overlap);
end