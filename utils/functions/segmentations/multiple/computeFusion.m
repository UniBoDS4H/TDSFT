% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - segmentations (Cell array: [1, nSeg], Cells: matrix [height, width]):
%       the segmentations to be fused.
%   - fusionAlgorithm (string):
%       the algorithm to be used for the fusion process.
%       (The algorithm must be in the folder "api/fusionAlgorithms")
%   - closeLineAlgoirthm (string):
%       the method to be used to close the resulting segmentation if it
%       is not already a close line.
%       (The algorithm must be in the folder "api/closeLineAlgorithms")
%   - varargin (Cell array: [1, nVarargin]):
%       the additional parameters of the algorithm.
%       (Some algorithms require additional parameters)
%
% OUTPUT:
%   - resSeg (Matrix [height, width]):
%       the resulting segmentation of the fusion process.
%
% THROWS:
%   - 'TDSFT:fusionProcess':
%       if the number of input segmentations is less than 2.
%
% DESCRIPTION:
%   Fuse the segmentations using the specified algorithm.
function resSeg = computeFusion(segmentations, fusionAlgorithm, closeLineAlgorithm, varargin)
    printName = erase(fusionAlgorithm, 'fusion_');
    printName = fromCamelCaseToSpacedString(printName);
    fprintf('Computing %s...\n', printName);

    % Throw an exception if the number of segmentations is less than 2.
    if length(segmentations) < 2
        throw(MException('TDSFT:fusionProcess', 'The number of segmentations must be at least 2'));
    end

    try        
        fun = str2func(fusionAlgorithm);
        if nargin > 3
            resSeg = fun(segmentations, varargin{:});
        else
            resSeg = fun(segmentations);
        end

        % Check if the resulting segmentation is already a close line.
        % If not, use the specified method to close it.
        segFill = imfill(resSeg, 'holes');
        if isequal(segFill, resSeg)
            fun = str2func(closeLineAlgorithm);
            resSeg = fun(resSeg, segmentations);
        end
    catch ME
        rethrow(ME);
    end
end