% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 2, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   filename (string):
%     the filename.
%
% OUTPUT:
%   result (string):
%     the filename without the extension.   
%
% DESCRIPTION:
%   Get the filename without extension.
%   Example: 'filename.m' = 'filename'.
function result = removeFileExtension(filename)
    expression = ".*(?=\.)";
    result = regexpi(filename, expression, "match");
    result = string(result);
end