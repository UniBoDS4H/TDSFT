function smallestSegmentation = getSmallestSegmentation(overlappedSegmentations, nSeg) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       overlappedSegmentations (Matrix [height, width]):
    %           the sum (overlap) of all the segmentations.
    %       nSeg (int):
    %           the number of segmentations
    %
    % OUTPUT:
    %       smallestSegmentation (Matrix [height, width]):
    %           the smallest segmentation.
    %
    % DESCRIPTION:
    %       The smallest segmentation is the perimeter of the area covered by every segmentation (the common area between every segmentation).  

    [smallestSegmentation, ~] = getCommonArea(overlappedSegmentations, nSeg);
end