function result = fromSpacedStringToCamelCase(s)
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 18, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       s (string):
    %           the spaced string.
    %
    % OUTPUT:
    %       result (string):
    %           the camel case string.
    % DESCRIPTION:
    %       Convert from spaced string to camelcase string.
    %       Spaced: This Is The Example String.
    %       CamelCase: ThisIsTheExampleString.
    
    result = regexprep(s, '([a-z]) ([A-Z])', '$1$2');
end