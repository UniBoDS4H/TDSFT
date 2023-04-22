function largestSegmentation = getLargestSegmentation(overlappedSegmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       overlappedSegmentations(Matrix: [height, width]:
    %           the sum (overlap) of all the segmentations.
    %
    % OUTPUT:
    %       largestSegmentation(Matrix: [height, width]):
    %           the largest segmentation.
    %
    % DESCRIPTION:
    %       Return the largest possible segmentation as a matrix height * width.
    %       The largest segmentation is the smallest segmentation possible which contains each input segmentation.

    % binarize the overlapped segmentations
    overlappedSegmentations = imbinarize(overlappedSegmentations);

    % fill the resulting segmentation and get the perimeter
    filledOverlap = imfill(overlappedSegmentations, 'holes');
    largestSegmentation = bwperim(filledOverlap);
end