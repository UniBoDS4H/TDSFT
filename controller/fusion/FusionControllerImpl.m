% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 19, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION:
%   Implementation of the FusionController interface.
classdef FusionControllerImpl < FusionController
    methods
        function resultSegmentation = executeFusion(~, segmentations, fusionAlgorithm, closingLineAlgorithm, varargin)
            printName = erase(fusionAlgorithm, 'fusion_');
            printName = fromCamelCaseToSpacedString(printName);
            fprintf('Computing %s...\n', printName);
        
            % Throw an exception if the number of segmentations is less than 2.
            if length(segmentations) < 2
                throw(MException("TDSFT:fusionProcess", "The number of segmentations must be at least 2"));
            end
        
            try        
                fun = str2func(fusionAlgorithm);
                if nargin > 3
                    resultSegmentation = fun(segmentations, varargin{:});
                else
                    resultSegmentation = fun(segmentations);
                end
        
                % Check if the resulting segmentation is already a close line.
                % If not, use the specified method to close it.
                segFill = imfill(resultSegmentation, "holes");
                if isequal(segFill, resultSegmentation)
                    fun = str2func(closingLineAlgorithm);
                    resultSegmentation = fun(resultSegmentation, segmentations);
                end
        
                % Fill and get the perimeter of the resulting segmentation
                % to remove not needed internal lines.
                segFill = imfill(resultSegmentation, "holes");
                resultSegmentation = bwperim(segFill);
            catch ME
                rethrow(ME);
            end
        end
    end
end