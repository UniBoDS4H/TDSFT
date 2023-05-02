% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 27, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   varargin: The function accept both 1 or 2 argument as follows:
%     - 1 argument: 
%         segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%           The smallest and the largest segmentation are obtained from this array.
%     - 2 arguments:
%         smallest (Matrix [height, width]):
%           the smallest segmentation.
%         largest (Matrix [height, width]):
%           the largest segmentation.
%
% OUTPUT:
%   averageSeg (matrix [height, width]):
%     The average segmentation.
%
% THROWS:
%   TDSFT:algorithms:
%     if the input is empty.
%
% DESCRIPTION:
%   Get the average segmentation between the smallest and the largest.
%   Can be passed as input the smallest and the largest segmentation or an array of
%   segmentations from which the smallest and the largest are obtained.
%   The average segmentation is obtained by taking the 1-pixel line in the middle of
%   the area between the two segmentations.
function averageSeg = algorithm_AverageSmallestLargest(varargin)
    disp('Getting the average segmentation between the smallest and the largest...');

    if nargin == 1
        segmentations = varargin{1};

        % Check if the input is empty, if it is the case throw an exception
        if isempty(segmentations)
            throw(MException('TDSFT:algorithms', 'Segmentations array empty'));
        end

        % If there is only one segmentation, return it
        if length(segmentations) == 1
            averageSeg = segmentations{1};
            return;
        end

        try
            smallest = algorithm_SmallestSegmentation(segmentations);
            largest = algorithm_LargestSegmentation(segmentations);
        catch ME
            rethrow(ME);
        end
    elseif nargin == 2
        smallest = varargin{1};
        largest = varargin{2};
    else
        throw(MException('TDSFT:algorithms', 'Wrong number of parameters'));
    end

    % Overlap the two smallest and the largest segmentations
    averageSeg = smallest + largest;
    
    % Fill the holes and get the area between the two segmentations
    averageSeg = imfill(averageSeg, 'holes') - imfill(smallest, 'holes');
    averageSeg = imbinarize(averageSeg);
    
    % Get 1-pixel line in the middle of the area between the two segmentations 
    averageSeg = bwskel(logical(averageSeg));

    % Fill the holes and get the perimeter to get the perfect average segmentation
    averageSeg = imfill(averageSeg, 'holes');
    averageSeg = bwperim(averageSeg);
end
