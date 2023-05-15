% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - algorithm (string):
%       an algorithm spaced name.
%       (e.g. 'Average Target Largest')
%
% OUTPUT:
%   - fullName (string):
%       fullName of the input algorithm.
%       (e.g. 'fusion_AverageTargetLargest')
%
% DESCRIPTION:
%   Get, from a spaced algorithm name, its full name.
%   Example: 'Average Target Largest' = 'fusion_AverageTargetLargest'.
function fullName = fromSpacedToFusionAlgorithmFullName(algorithm)    
    fullName = fromSpacedToCamelCaseString(algorithm);
    fullName = fromCamelCaseToFusionAlgorithmFullName(fullName);
end