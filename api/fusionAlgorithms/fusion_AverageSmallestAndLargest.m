% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 27, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   varargin: The function accepts both 1 or 2 parameters as follows:
%     - 1 parameter: 
%         - segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%             array containing the segmentations to fuse.
%             The smallest and the largest segmentation are obtained from this array.
%     - 2 parameters (in order):
%         - smallest (Matrix [height, width]):
%             the smallest segmentation.
%         - largest (Matrix [height, width]):
%             the largest segmentation.
%
% OUTPUT:
%   - averageSeg (matrix [height, width]):
%       the average segmentation.
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the input param number is wrong.
%
% DESCRIPTION:
%   Get the average segmentation between the smallest and the largest one.
%   The average segmentation is obtained by taking the 1-pixel line in the middle of
%   the area between the two segmentations.
%   The function accepts as input both an array of segmentations or (in order) the smallest
%   and the largest segmentation.
function averageSeg = fusion_AverageSmallestAndLargest(varargin)
    % If it is passed an array of segmentations, get the smallest and the largest.
    if nargin == 1
        segmentations = varargin{1};
        try
            smallest = fusion_Smallest(segmentations);
            largest = fusion_Largest(segmentations);
        catch ME
            rethrow(ME);
        end
    elseif nargin == 2
        smallest = varargin{1};
        largest = varargin{2};
    else
        throw(MException("TDSFT:fusionProcess", "Wrong number of parameters"));
    end

    % Overlap the smallest and the largest segmentations.
    averageSeg = smallest + largest;
    
    % Fill the holes and get the area between the two segmentations.
    averageSeg = imfill(averageSeg, "holes") - imfill(smallest, "holes");
    averageSeg = imbinarize(averageSeg);
    
    % Get 1-pixel line in the middle of the area between the two segmentations. 
    averageSeg = bwskel(logical(averageSeg));

    % Fill the holes and get the perimeter to get the perfect average segmentation.
    averageSeg = imfill(averageSeg, "holes");
    averageSeg = bwperim(averageSeg);
end
