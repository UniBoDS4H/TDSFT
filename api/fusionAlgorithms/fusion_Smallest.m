% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   varargin: The function accept both 1 or 2 parameters as follows:
%     - 1 parameter: 
%         segmentations (Cell array: [1, raters], Cells: matrix [height, width]):
%           array containing the segmentations to fuse.
%     - 2 parameters:
%         - overlap (Matrix [height, width]):
%             the overlap of the segmentations (the segmentations are already overlapped).
%             (The algorithm needs DENSE segmentation, so before the overlap you have to fill them)
%         - nSeg (Integer):
%             the number of segmentations.
%
% OUTPUT:
%   - smallestSegmentation (Matrix [height, width]):
%       the smallest segmentation.
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the input param number is wrong.
%
% DESCRIPTION:
%   Fuse all the segmentations together overlapping them if needed and getting the smallest segmentation possible.
%   The smallest segmentation is the perimeter of the common area covered by every segmentation (the common area between every segmentation).
function smallestSegmentation = fusion_Smallest(varargin)  
    % If the segmentations are not overlapped, overlap them.
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
        throw(MException("TDSFT:fusionProcess", "Wrong number of input arguments"));
    end

    [~, smallestSegmentation] = getCommonArea(overlap, nSeg);
end