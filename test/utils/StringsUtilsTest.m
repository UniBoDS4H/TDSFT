% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   May 19, 2023
% NAME:   TDSFT (version 1.0)
%
% DESCRIPTION:
%   Test class for `StringsUtils`.
classdef StringsUtilsTest < matlab.unittest.TestCase
    properties (TestParameter)
        camelCaseAlgorithmName = {"AverageTargetLargest"};          % Camel case algorithm name
        algorithmFullName =  {"fusion_AverageTargetLargest"};       % Algorithm full name
        spacedAlgorithmName = {"Average Target Largest"};           % Spaced algorithm name
            
        camelCaseClosingName = {"ChanVese"};                        % Camel case closing algorithm name
        closingFullName =  {"closing_ChanVese"};                    % Closing algorithm full name
        spacedClosingName = {"Chan Vese"};                          % Spaced closing algorithm name
            
        fileName = {"fusion_AverageTargetLargest.m"};               % File name
        fileNameWithoutExtension = {"fusion_AverageTargetLargest"}; % File name without extension
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