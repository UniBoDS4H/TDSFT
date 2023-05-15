% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%       array containing the segmentations to fuse.
%   - algorithm:
%       algorithm to use for the last two segmentations left if the segmentations are even.
%       Available algorithms: 
%         - 'Largest segmentation'
%         - 'Smallest segmentation'
%         - 'Average smallest and largest segmentation'
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the number of segmentations is even and the algorithm is not specified.
%   - 'TDSFT:fusionProcess':
%       if the algorithm specified is not available.
%
% OUTPUT:
%   - middleSegmentation (Matrix [height, width])):
%       the middle segmentation.
%
% DESCRIPTION:
%   Get the middle segmentation.
%   Discard outliers until the middle segmentation is reached. To do that iterate over the segmentations and
%   discard the largest and the smallest segmentation at each iteration.
%   If the number of segmentations is even specify a method for the last two segmentations left.
%   The available methods are:
%     - 'Largest segmentation': use the largest segmentation;
%     - 'Smallest segmentation': use the smallest segmentation;
%     - 'Average smallest and largest segmentation': use the average between the smallest and the largest segmentation.
%   (for more details see functions related to algorithms)
function middleSegmentation = fusion_Middle(segmentations, algorithm)     
    % Check if the number of segmentations is even and the algorithm is specified.
    if mod(length(segmentations), 2) == 0 && nargin < 2
        throw(MException("TDSFT:fusionProcess",...
            "If the number of segmentations is even, the algorithm must be specified"));
    end

    overlap = overlapSegmentations(segmentations);

    nSeg = length(segmentations); % number of segmentations
    nIt = floor( (nSeg - 1) / 2 ); % total number of iterations

    % Fill segmentations and overlap.
    filledSegmentations = getFilledSegmentations(segmentations);
    overlapFilled = overlapSegmentations(filledSegmentations);

    % At each iteration discard the largest and the smallest segmentation.
    for i=1:nIt
        largest = uint8( fusion_Largest(overlap) );
        smallest = uint8( fusion_Smallest(overlapFilled, nSeg) );

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
        algorithm = fromSpacedToFusionAlgorithmFullName(algorithm);
        if strcmp(algorithm, "fusion_Largest")
            middleSegmentation = fusion_Largest(overlap);
        elseif strcmp(algorithm, "fusion_Smallest")
            middleSegmentation = fusion_Smallest(overlapFilled, nSeg);
        elseif strcmp(algorithm, "fusion_AverageSmallestAndLargest")
            smallest = fusion_Smallest(overlapFilled, nSeg);
            largest = fusion_Largest(overlap);
            middleSegmentation = fusion_AverageSmallestAndLargest(smallest, largest);
        else
            throw(MException("TDSFT:fusionProcess", "Algorithm not available"));
        end
    else
        middleSegmentation = imbinarize(overlap);
    end

end