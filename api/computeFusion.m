function resSeg = computeFusion(segmentations, algorithm)
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

    % Firstly, get the algorithm fullname
    algorithmName = getAlgorithmFullName(algorithm);
    fun = str2func(algorithmName);
    resSeg = fun(segmentations);
end