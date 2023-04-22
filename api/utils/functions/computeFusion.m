function resSeg = computeFusion(segmentations, algorithm, varargin)
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations (Cell array: [1, nSeg] (Cells: matrix [height, width]):
    %           the segmentations to be fused.
    %       algorithm (string):
    %           the algorithm to be used for the fusion process.
    %
    % OUTPUT:
    %       resSeg (Matrix [height, width]):
    %           the resulting segmentation of the fusion process.
    %
    % DESCRIPTION:
    %       Fuse the segmentations using the specified algorithm.

    try        
        fun = str2func(algorithm);
        if nargin > 2
            resSeg = fun(segmentations, varargin);
        else
            resSeg = fun(segmentations);
        end
    
    %Error is handled by the caller
    catch ME
        rethrow(ME);
    end
end