% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 19, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION:
%   Test class for `StringsUtils`.
classdef StringsUtilsTest < matlab.unittest.TestCase
    properties (TestParameter)
        camelCaseAlgorithmName = {"AverageTargetLargest"};
        algorithmFullName =  {"fusion_AverageTargetLargest"};
        spacedAlgorithmName = {"Average Target Largest"};

        camelCaseClosingName = {"ChanVese"};
        closingFullName =  {"closing_ChanVese"};
        spacedClosingName = {"Chan Vese"};

        fileName = {"fusion_AverageTargetLargest.m"};
        fileNameWithoutExtension = {"fusion_AverageTargetLargest"};
    end
    
    methods (Test)
        % Test function fromCamelCaseToFusionAlgorithmFullName
        function fromCamelCaseToFusionAlgorithmFullNameTest(testCase, camelCaseAlgorithmName, algorithmFullName)
            funRes = StringsUtils.fromCamelCaseToFusionAlgorithmFullName(camelCaseAlgorithmName);
            testCase.verifyEqual(funRes, algorithmFullName);
        end

        % Test function fromCamelCaseToSpacedString
        function fromCamelCaseToSpacedStringTest(testCase, camelCaseAlgorithmName, spacedAlgorithmName)
            funRes = StringsUtils.fromCamelCaseToSpacedString(camelCaseAlgorithmName);
            testCase.verifyEqual(funRes, spacedAlgorithmName);
        end

        % Test function fromSpacedToClosingAlgorithmFullName
        function fromSpacedToClosingAlgorithmFullNameTest(testCase, spacedClosingName, closingFullName)
            funRes = StringsUtils.fromSpacedToClosingAlgorithmFullName(spacedClosingName);
            testCase.verifyEqual(funRes, closingFullName);
        end

        % Test function fromSpacedToFusionAlgorithmFullName
        function fromSpacedToFusionAlgorithmFullNameTest(testCase, spacedAlgorithmName, algorithmFullName)
            funRes = StringsUtils.fromSpacedToFusionAlgorithmFullName(spacedAlgorithmName);
            testCase.verifyEqual(funRes, algorithmFullName);
        end

        % Test function fromSpacedToFusionAlgorithmFullName
        function removeFileExtensionTest(testCase, fileName, fileNameWithoutExtension)
            funRes = StringsUtils.removeFileExtension(fileName);
            testCase.verifyEqual(funRes, fileNameWithoutExtension);
        end 
    end

end