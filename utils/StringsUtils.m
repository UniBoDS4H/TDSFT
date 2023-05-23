% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   May 19, 2023
% NAME:   TDSFT (version 1.0)
%
% Utils class for strings.
classdef StringsUtils
    methods (Static)

        function fullName = fromCamelCaseToFusionAlgorithmFullName(algorithm)
            % Get the full name of the camel case in.
            % Fullname is needed in the standalone version to recognize algorithm files.
            % Example: 'fusion_' + 'AverageTargetLargest' = 'fusion_AverageTargetLargest'
            %
            % Parameters:
            %   - algorithm (string):
            %       an algorithm name (already in camelcase).
            %       (e.g. 'AverageTargetLargest').
            %
            % Output:
            %   - fullName (string):
            %       fullName of the algorithm.
            %       (e.g. 'fusion_AverageTargetLargest').    

            fullName = strcat(Constants.ALGORITHM_NAMES_FILE_ROOT, algorithm);
        end

        function result = fromCamelCaseToSpacedString(s)
            % Convert from camelcase string to spaced string.
            % Example: 'ThisIsTheExampleString' = 'This Is The Example String'.
            %
            % Parameters:
            %   - s (string):
            %       the camel case string.
            %       (e.g. 'ThisIsACamelCaseString').
            %
            % Output:
            %   - result (string):
            %       the spaced string.
            %       (e.g. 'This Is A Spaced String').

            result = regexprep(s, "([a-z])([A-Z])", "$1 $2");
        end

        function result = fromSpacedToCamelCaseString(s)
            % Convert from spaced string to camelcase string.
            % Example: 'This Is The Example String' = 'ThisIsTheExampleString'.
            %
            % Parameters:
            %   - s (string):
            %       string with spaces.
            %       (e.g. 'This Is A String With Spaces').
            %
            % Output:
            %   - result (string):
            %       the string where spaces are replaced by camel case separation.
            %       (e.g. 'ThisIsACamelCaseString').

            result = regexprep(s, "([a-z]) ([A-Z])", "$1$2");
        end

        function result = fromSpacedToClosingAlgorithmFullName(s)
            % Convert from spaced string to closing algorithm fullname.
            % Example: 'Chan Vese' = 'closing_ChanVese'.
            %
            % Parameters:
            %   - s (string):
            %       the spaced string.
            %       (e.g. 'Chan Vese').
            %
            % Output:
            %   - result (string):
            %       the camelcase fullname.
            %       (e.g. 'closing_ChanVese').

            result = StringsUtils.fromSpacedToCamelCaseString(s);
            result = strcat(Constants.CLOSING_NAMES_FILE_ROOT, result);
        end

        function fullName = fromSpacedToFusionAlgorithmFullName(algorithm)
            % Get, from a spaced algorithm name, its full name.
            % Example: 'Average Target Largest' = 'fusion_AverageTargetLargest'.
            %
            % Parameters:
            %   - algorithm (string):
            %       an algorithm spaced name.
            %       (e.g. 'Average Target Largest').
            %
            % Output:
            %   - fullName (string):
            %       fullName of the input algorithm.
            %       (e.g. 'fusion_AverageTargetLargest').

            fullName = StringsUtils.fromSpacedToCamelCaseString(algorithm);
            fullName = StringsUtils.fromCamelCaseToFusionAlgorithmFullName(fullName);
        end
 
        function result = removeFileExtension(filename)
            % Returns the filename without the extension.
            % Example: 'filename.m' = 'filename'.
            %
            % Parameters:
            %   - filename (string):
            %       a filename.
            %
            % Output:
            %   - result (string):
            %       the filename without the extension.

            % Regex expression, matches everything before the last dot.
            expression = ".*(?=\.)";
            result = regexpi(filename, expression, "match");
            result = string(result);
        end
    end
end