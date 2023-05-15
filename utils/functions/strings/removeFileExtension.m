% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 2, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   - filename (string):
%       a filename.
%
% OUTPUT:
%   - result (string):
%       the filename without the extension.   
%
% DESCRIPTION:
%   Returns the filename without the extension.
%   Example: 'filename.m' = 'filename'.
function result = removeFileExtension(filename)
    % Regex expression, matches everything before the last dot.
    expression = ".*(?=\.)";
    result = regexpi(filename, expression, "match");
    result = string(result);
end