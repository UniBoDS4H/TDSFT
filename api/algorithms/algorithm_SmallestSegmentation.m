function smallestSegmentation = algorithm_SmallestSegmentation(segmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
    %           segmentations to fuse.
    %
    % OUTPUT:
    %       smallestSegmentation (Matrix [height, width]):
    %           the smallest segmentation.
    % THROWS:
    %       smallestSegmentations:emptyInput (Exception):
    %           throwed if the input is empty.
    %
    % DESCRIPTION:
    %       Fuse all    % the segmentations together overlapping them and getting the smallest segmentation possible.
    %       The smallest segmentation is the perimeter of the area covered by every segmentation (the common area between every segmentation).  
    
    disp('Getting the smallest segmentation...');

    % Check if the input is empty
    if isempty(segmentations)
        ME = MException('smallestSegmentation:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    % If there is only one segmentation, return it
    if length(segmentations) == 1
        smallestSegmentation = segmentations{1};
        return;
    end
    
    % overlap the filled segmentations
    filledSegmentations = [];
    for i=1:length(segmentations)
        filledSegmentations{i} = imfill(segmentations{i}, 'holes');
    end
    overlap = overlapSegmentations(filledSegmentations);

    % get the smallest segmentation
    nSeg = length(segmentations);
    smallestSegmentation = getSmallestSegmentation(overlap, nSeg);
end