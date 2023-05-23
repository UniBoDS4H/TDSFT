% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   May 19, 2023
% NAME:   TDSFT (version 1.0)
%
% DESCRIPTION:
%   Test class for functions operating on single segmentations.
classdef SingleSegmentationTest < matlab.unittest.TestCase
    properties (Constant)
        height = 100; % Image height.
        width = 100;  % Image width.
    end
        
    properties (TestParameter)
        % 8-bit image.
        image_8bit = { (power(2, 8) - 1) * ones(SingleSegmentationTest.height,...
            SingleSegmentationTest.width, "uint8") };
        % 12-bit image.
        image_12bit = { (power(2, 12) - 1) * ones(SingleSegmentationTest.height,...
            SingleSegmentationTest.width, "uint8") };
        % 16-bit image.
        image_16bit = { (power(2, 16) - 1) * ones(SingleSegmentationTest.height,...
            SingleSegmentationTest.width, "uint8") };
        % 32-bit image.
        image_32bit = { (power(2, 32) - 1) * ones(SingleSegmentationTest.height,...
            SingleSegmentationTest.width, "uint8") };
        % 64-bit image.
        image_64bit = { (power(2, 64) - 1) * ones(SingleSegmentationTest.height,...
            SingleSegmentationTest.width, "uint8") };
        % Binary image.
        binaryImage = { zeros(SingleSegmentationTest.height,...
            SingleSegmentationTest.width, "uint8") };
    end

    methods (Test)
        % Test imTo8bit with 8-bit image.
        function imTo8bitTest_8bitimage(testCase, image_8bit)
            % Test that imTo8bit returns an 8-bit image.
            funRes = imTo8bit(image_8bit);
            testCase.verifyClass(funRes, "uint8")
        end

        % Test imTo8bit with 12-bit image.
        function imTo8bitTest_12bitimage(testCase, image_12bit)
            % Test that imTo8bit returns an 8-bit image.
            funRes = imTo8bit(image_12bit);
            testCase.verifyClass(funRes, "uint8")
        end

        % Test imTo8bit with 16-bit image.
        function imTo8bitTest_16bitimage(testCase, image_16bit)
            % Test that imTo8bit returns an 8-bit image.
            funRes = imTo8bit(image_16bit);
            testCase.verifyClass(funRes, "uint8")
        end

        % Test imTo8bit with 32-bit image.
        function imTo8bitTest_32bitimage(testCase, image_32bit)
            % Test that imTo8bit returns an 8-bit image.
            funRes = imTo8bit(image_32bit);
            testCase.verifyClass(funRes, "uint8")
        end

        % Test imTo8bit with 64-bit image.
        function imTo8bitTest_64bitimage(testCase, image_64bit)
            % Test that imTo8bit returns an 8-bit image.
            funRes = imTo8bit(image_64bit);
            testCase.verifyClass(funRes, "uint8")
        end

        % Test getBinaryImageBackground with a binary image.
        function getBinaryImageBackgroundTest(testCase, binaryImage)
            funRes = getBinaryImageBackground(binaryImage);
            testCase.verifyFalse(funRes)

            binaryImage(1, 1) = 1;
            funRes = getBinaryImageBackground(binaryImage);
            testCase.verifyTrue(funRes)
        end

        % Test getOnePixelSegmentation.
        function getOnePixelSegmentationTest(testCase)
            image = zeros(SingleSegmentationTest.height,...
                SingleSegmentationTest.width, "uint8");
            
            % create a 10*10 square with a border of 3-pixel in the middle of the image
            image(45:55, 45:55) = 1;
            binaryImageThreePixel = image;
            binaryImageThreePixel(48:52, 48:52) = 0;

            % get the 1-pixel external perimeter
            binaryImageOnePixelExternal = binaryImageThreePixel;
            binaryImageOnePixelExternal(46:54, 46:54) = 0;
            
            funRes = getOnePixelSegmentation(binaryImageThreePixel, OnePixelLineTypes.EXTERNAL);
            testCase.verifyEqual(uint8(funRes), binaryImageOnePixelExternal)
        end
    end
end