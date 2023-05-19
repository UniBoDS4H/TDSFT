% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 19, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION:
%   Controller of the fusion process.
%   It gets the parameters of the fusion process from the gui and
%   calls the specified algorithm.
classdef FusionController
    methods (Abstract)
        % Execute the fusion process.
        %
        % Parameters:
        %   - segmentations (Cell array: [1, nSeg], Cells: matrix [height, width]):
        %       the segmentations to be fused.
        %   - fusionAlgorithm (string):
        %       the algorithm to be used for the fusion process.
        %       (The algorithm must be in the folder "api/fusionAlgorithms")
        %   - closingLineAlgorithm (string):
        %       the method to use to close the result segmentation if it
        %       is not already a close line.
        %       (The algorithm must be in the folder "api/closingLineAlgorithms")
        %   - varargin (Cell array: [1, nVarargin]):
        %       the additional parameters of the algorithm.
        %       (Some algorithms require additional parameters)
        %
        % Output:
        %   - resSeg (Matrix [height, width]):
        %       the resulting segmentation of the fusion process.
        %
        % Throws:           
        %   - 'TDSFT:fusionProcess':
        %       if the number of input segmentations is less than 2.
        resultSegmentation = executeFusion(obj, segmentations, fusionAlgorithm, closingLineAlgorithm, varargin)
    end
end