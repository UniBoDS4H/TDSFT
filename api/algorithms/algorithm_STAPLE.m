% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%
% OUTPUT:
%       gtSegmentation (Matrix [height, width]):
%           the ground truth segmentation computed with STAPLE algorithm.
%
% THROWS:
%       staple:emptyInput (Exception):
%           throwed if the input is empty.
%
% DESCRIPTION:
%       Use STAPLE algorithm to get the ground truth segmentation.
%
% REFERENCES:
%        Warfield, Simon K., Kelly H. Zou, and William M. Wells. 
%        "Simultaneous truth and performance level estimation (STAPLE): 
%        an algorithm for the validation of image segmentation." 
%        Medical Imaging, IEEE Transactions on 23.7 (2004): 903-921.
function gtSegmentation = algorithm_STAPLE(segmentations)
    disp('Executing STAPLE...');

    % check if the input is empty
    if isempty(segmentations)
        throw(MException('TDSFT:algorithms', 'Segmentations array empty'));
    end

    % if there is only one segmentation, return it
    if length(segmentations) == 1
        gtSegmentation = segmentations{1};
        return;
    end

    % convert to the right format for STAPLE
    stapleParam = [];
    for i=1:length(segmentations)
        seg = segmentations{i};
        stapleParam = [stapleParam, seg(:)];
    end
    
    [W, p, q] = STAPLE(stapleParam);

    % get segmentations dimensions
    imageDims = size(segmentations{1});

    % reshape to get the ground truth segmentation
    gtSegmentation = reshape((W >= .5), imageDims);
end