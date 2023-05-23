% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 23, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%       array containing the segmentations to fuse.
%   - target (int):
%       the index of the segmentation to be used as the main segmentation.
%
% OUTPUT:
%   - averageSeg (matrix [height, width]):
%       the average segmentation.
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the start segmentation index is greater than the number of segmentations.
%
% DESCRIPTION:
%   The average segmentation is computed by averaging the segmentations as follows:
%   for each pixel with value 1 of the start segmentation is searched for the closest pixel
%   with value 1 in the other segmentations.
%   Then, it is computed the average pixel:
%   - if the segmentations are 2, the average pixel is the middle point between the two pixels;
%   - if the segmentations are more than 2, the average pixel is the centroid of the pixels
%   (if the points are collinear is computed the middle point of the segment between the 
%   two extreme points). 
function averageSeg = fusion_AverageTargetFromInput(segmentations, target)   
    try
        % Check if the target segmentation is in the range.
        if target > length(segmentations) || target < 1
            throw(MException("TDSFT:fusionProcess", "Wrong start segmentation index"));
        end
        averageSeg = getAverageSegmentation(segmentations, target);
    catch ME
        rethrow(ME);
    end
end