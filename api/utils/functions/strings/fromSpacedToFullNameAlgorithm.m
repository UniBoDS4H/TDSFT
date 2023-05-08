% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   algorithm (string):
%     an algorithm spaced name.
%     (e.g. 'Average Target Largest')
%
% OUTPUT:
%   fullName (string):
%     fullName of the input algorithm.
%     (e.g. 'algorithm_AverageTargetLargest')
%
% DESCRIPTION:
%   Get, from a spaced algorithm name, its fullname.
%   Example: 'Average Target Largest' = 'algorithm_AverageTargetLargest'.
function fullName = fromSpacedToFullNameAlgorithm(algorithm)    
    fullName = fromSpacedToCamelCaseString(algorithm);
    fullName = fromCamelCaseToFullNameAlgorithm(fullName);
end