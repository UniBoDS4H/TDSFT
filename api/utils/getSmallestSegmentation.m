function res = getSmallestSegmentation(overlappedSegmentations, nSeg) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: April 11, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       overlappedSegmentations: the sum of all the segmentations
    %       nSeg: the number of segmentations
    %
    % OUTPUT:
    %       res: the smallest segmentation
    %
    % DESCRIPTION:
    %       The smallest segmentation is the one where are present the common parts from all the segmentations.  
    %

    [res, ~] = getCommonArea(overlappedSegmentations, nSeg);
end