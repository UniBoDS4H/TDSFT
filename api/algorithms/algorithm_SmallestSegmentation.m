function res = algorithm_LargestSegmentation(segmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: March 29, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations: the aligned segmentations to be fused together 
    %
    % OUTPUT:
    %       res: the resulting segmentation
    %
    % DESCRIPTION:
    %       Fuse all the segmentations together overlapping them and getting the smallest segmentation possible.
    %       The smallest segmentation is the one where are present the common parts from all the segmentations.  
    %
    
    disp('Getting the smallest segmentation...');

    if isempty(segmentations)
        ME = MException('smallestSegmentation:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    if length(segmentations) == 1
        res = segmentations{1};
        return;
    end

    filledSegmentations = [];

    % overlap all the segmentations
    for i=1:length(segmentations)
        filledSegmentations{i} = imfill(segmentations{i}, 'holes');
    end

    % overlap the segmentations
    overlap = overlapSegmentations(filledSegmentations);

    nSeg = size(segmentations, 2);
    [res, ~] = getCommonArea(overlap, nSeg);
end