% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 10, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   fusionResult (Matrix [height, width]):
%     the result of the fusion process.
%
% OUTPUT:
%   fusionResult (Matrix: [height, width]):
%     same as input.

% DESCRIPTION:
%   Simple function to permit to see the result of the fusion process
%   without applying the closing operation.
function fusionResult = closing_NoClosing(fusionResult, ~)
    % Do nothing
end