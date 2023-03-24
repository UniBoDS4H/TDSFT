function fullName = getAlgorithmFullName(algorithm)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 24, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       algorithm: algorithm name.
%
% OUTPUT:
%       fullName: fullName of the algorithm.
% DESCRIPTION:
%       Get the full name of the specified algorithm.
%       FullName: 'algorithm_' + algorithmName.

    fullName = strcat('algorithm_', algorithm);
end