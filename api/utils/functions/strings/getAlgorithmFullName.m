% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       algorithm (string):
%           algorithm name.
%
% OUTPUT:
%       fullName (string):
%           fullName of the algorithm.
% DESCRIPTION:
%       Get the full name of the specified algorithm.
%       FullName: 'algorithm_' + algorithmName.
%       Fullname is needed in the standalone version to recognize algorithm files.
%       Example: 'algorithm_' + 'TDSFT' = 'algorithm_TDSFT'.
function fullName = getAlgorithmFullName(algorithm)
    fullName = strcat("algorithm_", algorithm);
end