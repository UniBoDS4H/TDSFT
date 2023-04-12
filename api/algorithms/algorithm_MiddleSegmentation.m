function middleSegmentation = algorithm_MiddleSegmentation(segmentations, algorithm) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
    %           segmentations to fuse.
    %
    %       algorithm:
    %           method to use for the last two segmentations left if the segmentations are even.
    %
    % THROWS:
    %       middleSegmentations:emptyInput (Exception):
    %           throwed if the input is empty.
    %
    % OUTPUT:
    %       middleSegmentation (Matrix [height, width])):
    %           the middle segmentation.
    %
    % DESCRIPTION:
    %       Get the middle segmentation.
    %       Discard outliers until the middle segmentation is reached. To do that iterate over the segmentations and
    %       discard the largest and the smallest segmentation at each iteration.
    %       If the number of segmentations is even specify a method for the last two segmentations left.
    
    disp('Getting the middle segmentation...');

    % check if the input is empty
    if isempty(segmentations)
        ME = MException('middleSegmentation:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    % if there is only one segmentation, return it
    if length(segmentations) == 1
        middleSegmentation = segmentations{1};
        return;
    end

    overlap = overlapSegmentations(segmentations);

    nSeg = length(segmentations); % number of segmentations
    totIt = floor( (nSeg - 1) / 2 ); % total number of iterations

    % Get the filled segmentations needed to get the smallest segmentation      
    filledSegmentations = [];
    for i=1:length(segmentations)
        filledSegmentations{i} = imfill(segmentations{i}, 'holes');
    end
    overlapFilled = overlapSegmentations(filledSegmentations);

    % At each iteration discard the largest and the smallest segmentation
    for i=1:totIt
        largest = uint8( getLargestSegmentation(overlap) );
        smallest = uint8( getSmallestSegmentation(overlapFilled, nSeg) );

        overlap = overlap - largest;
        overlap = overlap - smallest;

        filledLargest = imfill(largest, 'holes');
        filledSmallest = imfill(smallest, 'holes');
        overlapFilled = overlapFilled - filledLargest;
        overlapFilled = overlapFilled - filledSmallest;

        nSeg = nSeg - 2;
    end

    middleSegmentation = imbinarize(overlap);

end