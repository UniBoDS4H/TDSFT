% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 13, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - s (string):
%       the spaced string.
%       (e.g. 'Chan Vese').
%
% OUTPUT:
%   - result (string):
%       the camelcase fullname.
%       (e.g. 'closing_ChanVese').
%
% DESCRIPTION:
%   Convert from spaced string to closing algorithm fullname.
%   Example: 'Chan Vese' = 'closing_ChanVese'.
function result = fromSpacedToClosingAlgorithmFullName(s)
    result = fromSpacedToCamelCaseString(s);
    result = strcat("closing_", result);
end