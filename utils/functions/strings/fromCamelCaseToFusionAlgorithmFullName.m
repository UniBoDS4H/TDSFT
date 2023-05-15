% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - algorithm (string):
%       an algorithm name (already in camelcase).
%       (e.g. 'AverageTargetLargest')
%
% OUTPUT:
%   - fullName (string):
%       fullName of the algorithm.
%       (e.g. 'fusion_AverageTargetLargest')
%
% DESCRIPTION:
%   Get the full name of the camel case in.
%   Fullname is needed in the standalone version to recognize algorithm files.
%   Example: 'fusion_' + 'AverageTargetLargest' = 'fusion_AverageTargetLargest'.
function fullName = fromCamelCaseToFusionAlgorithmFullName(algorithm)
    fullName = strcat("fusion_", algorithm);
end