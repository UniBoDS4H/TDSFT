function res = getLargestSegmentation(segmentations) 
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

    % overlap all the segmentations
    overlap = [];
    for seg = segmentations:
        overlap = overlap + seg;
    end 

    % fill the resulting segmentation and get the perimeter
    fillOverlap = imfill(overlap, 'holes');
    res = bwperim(fillOverlap);
    
end