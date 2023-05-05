% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%     array containing the segmentations to fuse.
%   algorithm:
%     algorithm to use for the last two segmentations left if the segmentations are even.
%     Available algorithms: 
%       - 'LargestSegmentation'
%       - 'SmallestSegmentation'
%       - 'AverageSmallestAndLargest'
%
% THROWS:
%   TDSFT:algorithms:
%     throwed if the input is empty.
%   TDSFT:algorithms:
%     throwed if the number of segmentations is even and the algorithm is not specified.
%   TDSFT:algorithms:
%     throwed if the algorithm choosed if the number of segmentations is even is not available.
%
% OUTPUT:
%   middleSegmentation (Matrix [height, width])):
%     the middle segmentation.
%
% DESCRIPTION:
%   Get the middle segmentation.
%   Discard outliers until the middle segmentation is reached. To do that iterate over the segmentations and
%   discard the largest and the smallest segmentation at each iteration.
%   If the number of segmentations is even specify a method for the last two segmentations left.
function middleSegmentation = algorithm_Middle(segmentations, algorithm)     
    disp('Getting the middle...');

    % check if the input is empty
    if isempty(segmentations)
        throw(MException('TDSFT:algorithms', 'Segmentations array empty'));
    end

    % check if the number of segmentations is even and the algorithm is specified
    if mod(length(segmentations), 2) == 0 && nargin < 2
        throw(MException('TDSFT:algorithms', 'If the number of segmentations is even, the algorithm must be specified'));
    end

    % if there is only one segmentation, return it
    if length(segmentations) == 1
        middleSegmentation = segmentations{1};
        return;
    end

    try
        overlap = overlapSegmentations(segmentations);
    catch ME
        rethrow(ME);
    end

    nSeg = length(segmentations); % number of segmentations
    totIt = floor( (nSeg - 1) / 2 ); % total number of iterations

    % preallocate the filled segmentations array
    filledSegmentations = cell(1, length(segmentations));

    % Get the filled segmentations needed to get the smallest segmentation      
    for i=1:length(segmentations)
        filledSegmentations{i} = imfill(segmentations{i}, 'holes');
    end

    try
        overlapFilled = overlapSegmentations(filledSegmentations);
    catch ME
        rethrow(ME);
    end

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
        if strcmp(algorithm, 'algorithm_Largest')
            middleSegmentation = getLargestSegmentation(overlap);
        elseif strcmp(algorithm, 'algorithm_Smallest')
            middleSegmentation = getSmallestSegmentation(overlapFilled, nSeg);
        elseif strcmp(algorithm, 'algorithm_AverageSmallestAndLargest')
            smallest = getSmallestSegmentation(overlapFilled, nSeg);
            largest = getLargestSegmentation(overlap);
            middleSegmentation = algorithm_AverageSmallestAndLargest(smallest, largest);
        else
            throw(MException('TDSFT:algorithms', 'Algorithm not available'));
        end
    else
        % if the number of segmentations is odd, return the segmentation left
        middleSegmentation = imbinarize(overlap);
    end

end