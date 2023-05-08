% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   varargin: The function accept both 1 or 2 argument as follows:
%     - 1 argument: 
%         segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%     - 2 arguments:
%         overlap (Matrix [height, width]):
%           the overlap of the segmentations (the segmentations are already overlapped).
%           Before calling this function, the segmentations must be filled (need to be dense).
%         nSeg (Integer):
%           the number of segmentations.
%
% OUTPUT:
%   smallestSegmentation (Matrix [height, width]):
%     the smallest segmentation.
%
% THROWS:
%   TDSFT:algorithms:
%     throwed if the input param number is wrong.
%
% DESCRIPTION:
%   Fuse all the segmentations together overlapping them if needed and getting the smallest segmentation possible.
%   The smallest segmentation is the perimeter of the area covered by every segmentation (the common area between every segmentation).
function smallestSegmentation = algorithm_Smallest(varargin)  
    % if the segmentations are not overlapped, overlap them
    if nargin == 1
        segmentations = varargin{1};
        nSeg = length(segmentations);
        
        % Fill and overlap the segmentations.
        filledSegmentations = getFilledSegmentations(segmentations);
        overlap = overlapSegmentations(filledSegmentations);

    elseif nargin == 2
        overlap = varargin{1};
        nSeg = varargin{2}; 
    else
        throw(MException('TDSFT:algorithms', 'Wrong number of input arguments'));
    end

    [~, smallestSegmentation] = getCommonArea(overlap, nSeg);
end