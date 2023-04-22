% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 18, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       s (string):
%           the camel case string.
%
% OUTPUT:
%       result (string):
%           the spaced string.
% DESCRIPTION:
%       Convert from camelcase string to spaced string.
%       CamelCase: ThisIsTheExampleString.
%       Spaced: This Is The Example String.
function result = fromCamelCaseToSpacedString(s)
    result = regexprep(s, '([a-z])([A-Z])', '$1 $2');
end