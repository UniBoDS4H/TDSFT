% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img (Matrix [height, width]):
%           the image to convert.
%       dense (boolean):
%           true (1) if a dense object is present and more test are wanted/neeeded, false (0) otherwise.
%           It adds more check to the segmentation to be able to recognize open lines and close dense lines.
%       internal (boolean):
%           if true (1), the internal line is required (when segmentation of more than one pixel).
%       middle (boolean):
%           if true (1), the middle line is required (when segmentation of more than one pixel).
%
% OUTPUT:
%       bw (Matrix [height, width]):
%           image converted to black and white.
%       seg (Matrix [height, width]):
%           segmentation of the object.
%       wrn (boolean):
%           true if the input image had more than one channel but was not an rgb image.
%           If it is the case it will be used only the first channel
%
% THROWS:
%       processImage:openedSegmentation (Exception):
%           throwed if the segmentation is an open line.
%
%       processImage:emptySegmentation (Exception):
%           throwed if the segmentation is empty.
%
% DESCRIPTION:
%       - Converts the image to 8 bit;
%       - Convertes the image to black white;
%       - Get the segmentation (perimeter) of the object contained in the image;
%
%       - CANNOT BE TRUE BOTH DENSE AND INTERNAL (or MIDDLE), if the object is dense there is no internal line.
%       - CANNOT BE TRUE BOTH INTERNAL AND MIDDLE, only one option for the segmentation of more than one pixel is allowed.
%       The default option for line segmentation is the external line.
function [bw, seg, wrn] = processImage(img, dense, internal, middle)
    % Check the channels of the image
    % If the image has more than one channel but is not an rgb image, use only the first channel
    if size(img,3) ~= 1 && size(img,3) ~= 3
        img = img(:,:,1);
        wrn = true;
    else
        wrn = false;
    end

    try
        % Convert to 8 bit image
        cImg = imTo8bit(img);

        % Convert to grayscale
        grayImg = im2gray(cImg);

        % Convert to bw
        bw = imbinarize(grayImg);

        % Convert to black background if needed
        if isWhiteBackground(bw)
            bw = ~bw;
        end

        % If there are more than one object, select the largest one
        [~, numBlobs] = bwlabel(bw);
        if numBlobs > 1
            bw = bwareafilt(bw, 1);
        end

        % Check line closing
        if ~isSegmentationClosed(bw, dense)
            ME = MException('processImage:openedSegmentation', 'Segmentation not closed');
            throw(ME);
        end

        % Check if the segmentation is empty
        if ~sum(bw(:))
            ME = MException('processImage:emptySegmentation', 'Segmentation empty');
            throw(ME);
        end

        % Check if the segmentation is already single pixel 
        if isequal(bw, bwperim(bw))
            seg = bw;
            return; 
        end

        seg = getOnePixelSegmentation(bw, internal, middle);
        
    catch ME 
        % Rethrow the error
        % It will be catched by the gui
        rethrow(ME);
    end
end