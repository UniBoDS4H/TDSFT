% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 19, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION:
%   Implementation of the FusionController interface.
classdef ControllerImpl < Controller
    methods
        function resultSegmentation = executeFusion(~, segmentations, fusionAlgorithm, closingLineAlgorithm, varargin)
            printName = erase(fusionAlgorithm, 'fusion_');
            printName = StringsUtils.fromCamelCaseToSpacedString(printName);
            fprintf('Computing %s...\n', printName);
        
            % Throw an exception if the number of segmentations is less than 2.
            if length(segmentations) < 2
                throw(MException("TDSFT:fusionProcess", "The number of segmentations must be at least 2"));
            end
        
            try        
                fun = str2func(fusionAlgorithm);
                if nargin > 3
                    resultSegmentation = fun(segmentations, varargin{:});
                else
                    resultSegmentation = fun(segmentations);
                end
        
                % Check if the resulting segmentation is already a close line
                % (to check this we check that the number of non-zero pixels
                % of the filled segmentation is at least twice the number of
                % non-zero pixels of the segmentation).
                % If not, use the specified method to close it.
                segFill = imfill(resultSegmentation, "holes");
                nzSegFill = nnz(segFill);
                nzSeg = nnz(resultSegmentation);
                if nzSegFill < 2 * nzSeg
                    fun = str2func(closingLineAlgorithm);
                    resultSegmentation = fun(resultSegmentation, segmentations);
                end

                % Fill and get the perimeter of the resulting segmentation
                % to remove not needed internal lines.
                segFill = imfill(resultSegmentation, "holes");
                resultSegmentation = bwperim(segFill);
            catch ME
                rethrow(ME);
            end
        end

        function [blackAndWhiteImg, segmentation, wrn] = processImage(~, img, dense, line)
            % Check the parameters.
            % If dense is true only external line can be used.
            if dense && ~strcmp(line, "external")
                throw(MException("TDSFT:processImage", "Dense object can only have external line"));
            end

            % Check the channels of the image.
            % If the image has more than one channel but is not an rgb image, use only the first channel.
            % Use the wrn variable to warn the user about that.
            if size(img,3) ~= 1 && size(img,3) ~= 3
                img = img(:,:,1);
                wrn = true;
            else
                wrn = false;
            end

            try
                % Convert to 8 bit image.
                cImg = imTo8bit(img);

                % Convert to grayscale.
                grayImg = im2gray(cImg);

                % Convert to black and white.
                blackAndWhiteImg = imbinarize(grayImg);

                % Convert to black background if needed.
                % We want the background to be black and the segmentation to be white.
                if getBinaryImageBackground(blackAndWhiteImg)
                    blackAndWhiteImg = ~blackAndWhiteImg;
                end

                % If there are more than one object, select the largest one.
                [~, numBlobs] = bwlabel(blackAndWhiteImg);
                if numBlobs > 1
                    blackAndWhiteImg = bwareafilt(blackAndWhiteImg, 1);
                end

                % Check if the segmentation is an open line.
                if ~isSegmentationClosed(blackAndWhiteImg, dense)
                    throw(MException("TDSFT:processImage", "Not closed segmentation uploaded"));
                end

                % Check if the segmentation is empty.
                if ~sum(blackAndWhiteImg(:))
                    throw(MException("TDSFT:processImage", "Empty segmentation uploaded"));
                end

                % Check if the segmentation is already of one pixel. 
                if isequal(blackAndWhiteImg, bwperim(blackAndWhiteImg))
                    segmentation = blackAndWhiteImg;
                else
                    % Get the one pixel segmentation.
                    segmentation = getOnePixelSegmentation(blackAndWhiteImg, line);
                end
            catch ME 
                rethrow(ME);
            end
        end
    end
end