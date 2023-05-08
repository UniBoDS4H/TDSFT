% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%   img (Matrix [height, width]):
%     the image to convert.
%   dense (boolean):
%     true (1) if a dense object is present and more test are wanted/neeeded, false (0) otherwise.
%     It adds more check to the segmentation to be able to better recognize open lines and close dense lines.
%     Be careful, it is difficult to recognize a dense object from an open line of more than one pixel.
%     Since an open line of more than one pixel is, by definition, a dense object we use some statistics to
%     recognize a dense object from an open line of more than one pixel.
%     So if you are not sure that the object is dense, set dense to false.
%     If dense is true only external line can be used since dense object have no middle or internal line!
%   line (string):
%     the line to use if the segmentation is more than one pixel (external, middle or internal).
%     (see onePixelLineTypes.m for more details)
%
% OUTPUT:
%   bw (Matrix [height, width]):
%     image converted to black and white.
%   seg (Matrix [height, width]):
%     segmentation of the object.
%   wrn (boolean):
%     true if the input image had more than one channel but was not an rgb image.
%     If it is the case it will be used only the first channel
%
% THROWS:
%   TDSFT:processImage:
%     throwed if the segmentation dense is true and line is not external.
%   TDSFT:processImage:
%     throwed if the segmentation is an open line.
%   TDSFT:processImage:
%     throwed if the segmentation is empty.
%
% DESCRIPTION:
%   - Converts the image to 8-bit;
%   - Convertes the image to black and white;
%   - Convert to the required configuration (black background and white segmentation);
%   - If there are more than one object, select the largest one;
%   - Get the one pixel segmentation of the object contained in the image using the specified line;

%   ( If dense is true only external line can be used. If the object is dense there is no middle 
%   or internal line!.
function [bw, seg, wrn] = processImage(img, dense, line)
    %Ccheck the parameters.
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

        % Convert to bw.
        bw = imbinarize(grayImg);

        % Convert to black background if needed.
        % We want the background to be black and the segmentation to be white.
        if getBinaryImageBackground(bw)
            bw = ~bw;
        end

        % If there are more than one object, select the largest one.
        [~, numBlobs] = bwlabel(bw);
        if numBlobs > 1
            bw = bwareafilt(bw, 1);
        end

        % Check if the segmentation is an open line.
        if ~isSegmentationClosed(bw, dense)
            throw(MException("TDSFT:processImage", "Not closed segmentation uploaded"));
        end

        % Check if the segmentation is empty.
        if ~sum(bw(:))
            throw(MException("TDSFT:processImage", "Empty segmentation uploaded"));
        end

        % Check if the segmentation is already of one pixel. 
        if isequal(bw, bwperim(bw))
            seg = bw;
            return; 
        end

        % Get the one pixel segmentation.
        seg = getOnePixelSegmentation(bw, line);
    catch ME 
        rethrow(ME);
    end
end