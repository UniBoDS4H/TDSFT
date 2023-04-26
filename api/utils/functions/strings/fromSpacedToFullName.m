% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       algorithm (string):
%           algorithm spaced name.
%
% OUTPUT:
%       fullName (string):
%           fullName of the algorithm.
% DESCRIPTION:
%       Get the full name of the specified algorithm.
%       Example: 'Largest Segmentation' = 'algorithm_LargestSegmentation'.
function fullName = fromSpacedToFullName(algorithm)    
        fullName = fromSpacedStringToCamelCase(algorithm);
        fullName = getAlgorithmFullName(fullName);
end