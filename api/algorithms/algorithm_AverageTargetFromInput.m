% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 23, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%       startSegmentation (int):
%           The index of the segmentation to be used as main segmentation.
%
% OUTPUT:
%       averageSeg (matrix [height, width]):
%           The average segmentation.       
%
% DESCRIPTION:
%       The average segmentation is computed by averaging the segmentations as follows:
%       For each pixel with value 1 of the start segmentation is searched the closest pixel
%       with value 1 in the other segmentations. Then it is computed the average pixel:
%       - if the segmentations are 2, the average pixel is the middle point between the two pixels;
%       - if the segmentations are more than 2, the average pixel is the centroid of the pixels. 
function averageSeg = algorithm_AverageTargetFromInput(segmentations, startSegmentation)
    disp('Averaging...');
    
    try
        averageSeg = segmentations{startSegmentation};
    catch ME
        rethrow(ME);
    end
end