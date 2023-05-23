% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 23, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%       array containing the segmentations to fuse.
%
% OUTPUT:
%   - averageSeg (matrix [height, width]):
%       the average segmentation.       
%
% DESCRIPTION:
%   The average segmentation is computed by averaging the segmentations as follows:
%   for each pixel with value 1 of the largest segmentation is searched for the closest pixel
%   with value 1 of every input segmentation. Then it is computed the average pixel:
%   - if the segmentations are 2, the average pixel is the middle point between the two pixels;
%   - if the segmentations are more than 2, the average pixel is the centroid of the pixels
%     (if the points are collinear is computed the middle point of the segment between the 
%     two extreme points).  
function averageSeg = fusion_AverageTargetLargest(segmentations)
    try
        largest = fusion_Largest(segmentations);
        averageSeg = getAverageSegmentation(segmentations, largest);
    catch ME
        rethrow(ME);
    end
end