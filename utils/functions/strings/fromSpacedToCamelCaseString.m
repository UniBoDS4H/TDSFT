% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 18, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - s (string):
%       string with spaces.
%       (e.g. 'This Is A String With Spaces')
%
% OUTPUT:
%   - result (string):
%       the string where spaces are replaced by camel case separation.
%       (e.g. 'ThisIsACamelCaseString').
%
% DESCRIPTION:
%   Convert from spaced string to camelcase string.
%   Example: 'This Is The Example String' = 'ThisIsTheExampleString'.
function result = fromSpacedToCamelCaseString(s)
    result = regexprep(s, "([a-z]) ([A-Z])", "$1$2");
end