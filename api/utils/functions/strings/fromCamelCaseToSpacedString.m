% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 18, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   s (string):
%     the camel case string.
%     (e.g. 'ThisIsACamelCaseString').
%
% OUTPUT:
%   result (string):
%     the spaced string.
%     (e.g. 'This Is A Spaced String').
%
% DESCRIPTION:
% Convert from camelcase string to spaced string.
% Example: 'ThisIsTheExampleString' = 'This Is The Example String'.
function result = fromCamelCaseToSpacedString(s)
    result = regexprep(s, "([a-z])([A-Z])", "$1 $2");
end