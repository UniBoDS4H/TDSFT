function res = getLargestSegmentation(overlappedSegmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: April 11, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       overlappedSegmentations: the sum of all the segmentations 
    %
    % OUTPUT:
    %       res: the largest segmentation of the area
    %
    % DESCRIPTION:
    %       The largest possible segmentation (perimeter of the sum of all the segmentations).
    %

    overlappedSegmentations = imbinarize(overlappedSegmentations);
    overlappedSegmentations = uint8(~overlappedSegmentations);

    % fill the resulting segmentation and get the perimeter
    filledOverlap = imfill(overlappedSegmentations, 'holes');
    res = bwperim(filledOverlap);
end