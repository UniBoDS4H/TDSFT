% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 27, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%
% OUTPUT:
%       averageSeg (matrix [height, width]):
%           The average segmentation.
%
% THROWS:
%      TDSFT:algorithms:
%           if the input is empty.
%
% DESCRIPTION:
%       Get the average segmentation between the smallest and the largest.
%       The average segmentation is obtained by taking the 1-pixel line in the middle of
%       the area between the two segmentations.
function averageSeg = algorithm_AverageSmallestLargest(segmentations)
    disp('Getting the average segmentation between the smallest and the largest...');

    % Check if the input is empty, if it is the case throw an exception
    if isempty(segmentations)
        throw(MException('TDSFT:algorithms', 'Segmentations array empty'));
    end

    % If there is only one segmentation, return it
    if length(segmentations) == 1
        largestSegmentation = segmentations{1};
        return;
    end

    try
        smallest = algorithm_SmallestSegmentation(segmentations);
        largest = algorithm_LargestSegmentation(segmentations);
    catch ME
        rethrow ME;
    end

    % Overlap the two smallest and the largest segmentations and get the area between them
    averageSeg = smallest + largest;
    averageSeg = imbinarize(averageSeg);
    averageSeg = imfill(averageSeg, 'holes') - imfill(smallest, 'holes');

    % Get 1-pixel line in the middle of the area between the two segmentations 
    averageSeg = bwskel(logical(averageSeg));

    % Fill the holes and get the perimeter to get the perfect average segmentation
    averageSeg = imfill(averageSeg, 'holes');
    averageSeg = bwperim(averageSeg);
end
