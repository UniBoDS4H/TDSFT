function res = algorithm_LargestSegmentation(segmentations) 
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 24, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations: the aligned segmentations to be fused together 
%
% OUTPUT:
%       res: the resulting segmentation
%
% DESCRIPTION:
%       Fuse all the segmentations together overlapping them and getting the largest possible segmentation which contains all the inputs.
%

    % initialize the overlap

    disp('Getting the largest segmentation...');

    if isempty(segmentations)
        ME = MException('largestSegmentation:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    if length(segmentations) == 1
        res = segmentations{1};
        return;
    end

    invertedSegmentations = [];

    % overlap all the segmentations
    for i=1:length(segmentations)
        invertedSegmentations{i} = uint8(~segmentations{i});
    end

    overlap = overlapSegmentations(invertedSegmentations);

    overlap = imbinarize(overlap);
    overlap = uint8(~overlap);

    % fill the resulting segmentation and get the perimeter
    fillOverlap = imfill(overlap, 'holes');
    res = bwperim(fillOverlap);
end