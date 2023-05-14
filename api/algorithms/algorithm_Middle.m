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
%   The available methods are:
%     - 'LargestSegmentation': use the largest segmentation.
%     - 'SmallestSegmentation': use the smallest segmentation.
%     - 'AverageSmallestAndLargest': use the average between the smallest and the largest segmentation.
function middleSegmentation = algorithm_Middle(segmentations, algorithm)     
    % Check if the number of segmentations is even and the algorithm is specified
    if mod(length(segmentations), 2) == 0 && nargin < 2
        throw(MException('TDSFT:algorithms', 'If the number of segmentations is even, the algorithm must be specified'));
    end

    overlap = overlapSegmentations(segmentations);

    nSeg = length(segmentations); % number of segmentations
    totIt = floor( (nSeg - 1) / 2 ); % total number of iterations

    % Fill segmentations and overlap.
    filledSegmentations = getFilledSegmentations(segmentations);
    overlapFilled = overlapSegmentations(filledSegmentations);

    % At each iteration discard the largest and the smallest segmentation
    for i=1:totIt
        largest = uint8( algorithm_Largest(overlap) );
        smallest = uint8( algorithm_Smallest(overlapFilled, nSeg) );

        overlap = overlap - largest;
        overlap = overlap - smallest;

        filledLargest = imfill(largest, "holes");
        filledSmallest = imfill(smallest, "holes");
        overlapFilled = overlapFilled - filledLargest;
        overlapFilled = overlapFilled - filledSmallest;

        nSeg = nSeg - 2;
    end

    % If the number of segmentations is even, use the specified algorithm for the last two segmentations left.
    if isequal(nSeg, 2)
        algorithm = fromSpacedToFullNameAlgorithm(algorithm);
        if strcmp(algorithm, 'algorithm_Largest')
            middleSegmentation = algorithm_Largest(overlap);
        elseif strcmp(algorithm, 'algorithm_Smallest')
            middleSegmentation = algorithm_Smallest(overlapFilled, nSeg);
        elseif strcmp(algorithm, 'algorithm_AverageSmallestAndLargest')
            smallest = algorithm_Smallest(overlapFilled, nSeg);
            largest = algorithm_Largest(overlap);
            middleSegmentation = algorithm_AverageSmallestAndLargest(smallest, largest);
        else
            throw(MException('TDSFT:algorithms', 'Algorithm not available'));
        end
    else
        middleSegmentation = imbinarize(overlap);
    end

end