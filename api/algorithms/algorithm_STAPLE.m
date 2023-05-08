% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%     array containing the segmentations to fuse.
%
% OUTPUT:
%   gtSegmentation (Matrix [height, width]):
%     the ground truth segmentation computed with STAPLE algorithm.
%
% DESCRIPTION:
%   Use STAPLE algorithm to get the ground truth segmentation.
%
% REFERENCES:
%   Warfield, Simon K., Kelly H. Zou, and William M. Wells. 
%   "Simultaneous truth and performance level estimation (STAPLE): 
%   an algorithm for the validation of image segmentation." 
%   Medical Imaging, IEEE Transactions on 23.7 (2004): 903-921.
function gtSegmentation = algorithm_STAPLE(segmentations)
    % Convert to the right format for STAPLE.
    % (See STAPLE file for more details)

    % Get segmentations dimensions.
    imageDims = size(segmentations{1});
    nSeg = length(segmentations);

    % Preallocate the array.
    stapleParam = zeros(imageDims(1) * imageDims(2), nSeg);
    for i=1:length(segmentations)
        seg = segmentations{i};
        stapleParam(:, i) = seg(:);
    end
    [W, ~, ~] = STAPLE(stapleParam);

    % Reshape to get the ground truth segmentation.
    gtSegmentation = reshape((W >= .5), imageDims);
end