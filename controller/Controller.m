% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 19, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION:
%   Controller of the fusion process.
%   It gets the parameters of the fusion process from the gui and
%   calls the specified algorithm.
classdef Controller
    methods (Abstract)
        % Execute the fusion process.
        %
        % Parameters:
        %   - segmentations (Cell array: [1, nSeg], Cells: matrix [height, width]):
        %       the segmentations to be fused.
        %   - fusionAlgorithm (string):
        %       the algorithm to be used for the fusion process.
        %       (The algorithm must be in the folder "api/fusionAlgorithms")
        %   - closingLineAlgorithm (string):
        %       the method to use to close the result segmentation if it
        %       is not already a close line.
        %       (The algorithm must be in the folder "api/closingLineAlgorithms")
        %   - varargin (Cell array: [1, nVarargin]):
        %       the additional parameters of the algorithm.
        %       (Some algorithms require additional parameters)
        %
        % Output:
        %   - resSeg (Matrix [height, width]):
        %       the resulting segmentation of the fusion process.
        %
        % Throws:           
        %   - 'TDSFT:fusionProcess':
        %       if the number of input segmentations is less than 2.
        resultSegmentation = executeFusion(obj, segmentations, fusionAlgorithm, closingLineAlgorithm, varargin)

        %   Process the image doing the following steps:
        %   - Convert the image to 8-bit;
        %   - Convert the image to black and white;
        %   - Convert to the required configuration (black background and white segmentation);
        %   - If there are more than one object, select the largest one;
        %   - Get the one pixel segmentation of the object contained in the image using the specified method.
        %
        %   If dense is true only external line can be used. If the object is dense there is no middle 
        %   or internal line!.
        %
        % Parameters:
        %   - img (Matrix [height, width]):
        %       the image to convert.
        %   - dense (boolean):
        %       true (1) if a dense object is present and more test are wanted/neeeded, false (0) otherwise.
        %       It adds more checks to the segmentation to be able to better recognize open lines and close dense lines.
        %       Be careful, it is difficult to recognize a dense object from an open line of more than one pixel.
        %       Since an open line of more than one pixel is, by definition, a dense object we use some statistics to
        %       recognize a dense object from an open line of more than one pixel.
        %       So if you are not sure that the object is dense, set dense to false.
        %       If dense is true only external line can be used since a dense object have no middle or internal line!
        %   - line (string):
        %       the line to use if the segmentation is more than one pixel (external, middle or internal).
        %       (see onePixelLineTypes.m for more details)
        %
        % Outoput:
        %   - blackAndWhiteImg (Matrix [height, width]):
        %       original image converted to black and white.
        %   - segmentation (Matrix [height, width]):
        %       segmentation of the object.
        %   - wrn (boolean):
        %       true if the input image had more than one channel but was not an rgb image.
        %       If it is the case it will be used only the first channel
        %
        % Throws:
        %   - 'TDSFT:processImage':
        %       if the segmentation dense is true and line is not external.
        %   - 'TDSFT:processImage':
        %       if the segmentation is an open line.
        %   - 'TDSFT:processImage':
        %       if the segmentation is empty.
        [blackAndWhiteImg, segmentation, wrn] = processImage(obj, img, dense, line)
    end
end