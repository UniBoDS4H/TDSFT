% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%
%       algorithm:
%           algorithm to use for the last two segmentations left if the segmentations are even.
%           Available algorithms: 
%               - 'LargestSegmentation'
%               - 'SmallestSegmentation'
%
% THROWS:
%       middleSegmentations:emptyInput (Exception):
%           throwed if the input is empty.
%
%       middleSegmentations:wrongInputs (Exception):
%           throwed if the number of segmentations is even and the algorithm is not specified.
%
%       middleSegmentations:algorithmNotAvailable (Exception):
%           throwed if the algorithm choosed if the number of segmentations is even is not available.
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
function middleSegmentation = algorithm_MiddleSegmentation(segmentations, algorithm)     
    disp('Getting the middle segmentation...');

    % check if the input is empty
    if isempty(segmentations)
        ME = MException('middleSegmentation:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    % check if the number of segmentations is even and the algorithm is specified
    if mod(length(segmentations), 2) == 0 && nargin < 2
        ME = MException('middleSegmentation:wrongInputs', 'If the number of segmentations is even, the algorithm must be specified');
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

    % compute result
    if isequal(nSeg, 2)
        % if the number of segmentations is even, use the specified algorithm for the last two segmentations left
        algorithm = fromSpacedToFullName(algorithm);
        try
            if strcmp(algorithm, 'algorithm_LargestSegmentation')
                middleSegmentation = getLargestSegmentation(overlap);
            elseif strcmp(algorithm, 'algorithm_SmallestSegmentation')
                middleSegmentation = getSmallestSegmentation(overlapFilled, nSeg);
            else
                throw 'Algorithm not available';
            end
        catch ME
            rethrow(ME);
        end
    else
        % if the number of segmentations is odd, return the segmentation left
        middleSegmentation = imbinarize(overlap);
    end

end