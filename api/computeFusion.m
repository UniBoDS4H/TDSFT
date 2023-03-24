function res = computeFusion(segmentations, algorithm)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 20, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations: the segmentations to be fused.
%       algorithm: the algorithm to be used for the fusion process.
%
% OUTPUT:
%       res: the result of the fusion process
%
% DESCRIPTION:
%       Fuse the segmentations using the specified algorithm.

    alignedSegmentations = alignSegmentations(segmentations);

    fun = str2func(algorithm);
    res = fun(alignedSegmentations);
end