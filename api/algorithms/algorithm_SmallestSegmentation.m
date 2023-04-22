function smallestSegmentation = algorithm_SmallestSegmentation(varargin)
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       varargin: The function accept both 1 or 2 argument as follows:
    %
    %       1 param) 
    %           segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
    %               The array where each element is a segmentation.
    %       2 param):
    %           overlap (Matrix [height, width]):
    %               the overlap of the segmentations (the segmentations are already overlapped).
    %               Before calling this function, the segmentations must be filled (need to be dense).
    %           nSeg (Integer):
    %               the number of segmentations.
    %
    % OUTPUT:
    %       smallestSegmentation (Matrix [height, width]):
    %           the smallest segmentation.
    % THROWS:
    %       smallestSegmentations:emptyInput (Exception):
    %           throwed if the input is empty.
    %       smallestSegmentations:wrongInput (Exception):
    %           throwed if the input param number is wrong.
    %
    % DESCRIPTION:
    %       Fuse all the segmentations together overlapping them if needed and getting the smallest segmentation possible.
    %       The smallest segmentation is the perimeter of the area covered by every segmentation (the common area between every segmentation).  
    
    disp('Getting the smallest segmentation...');

    % if the segmentations are not overlapped, overlap them
    if nargin == 1
        segmentations = varargin{1};

        % Check if the input is empty
        if isempty(segmentations)
            ME = MException('smallestSegmentation:emptyInput', 'Segmentations array empty');
            throw(ME);
            return;
        end

        % If there is only one segmentation, return it
        nSeg = length(segmentations);
        if nSeg == 1
            smallestSegmentation = segmentations{1};
            return;
        end
        
        % overlap the filled segmentations
        filledSegmentations = [];
        for i=1:length(segmentations)
            filledSegmentations{i} = imfill(segmentations{i}, 'holes');
        end
        overlap = overlapSegmentations(filledSegmentations);

    elseif varargin == 2
        overlap = varargin{1};
        nSeg = varargin{2}; 
    else
        ME = MException('smallestSegmentation:wrongInput', 'Wrong number of input arguments');
        throw(ME);
        return;
    end

    smallestSegmentation = getSmallestSegmentation(overlap, nSeg);
end