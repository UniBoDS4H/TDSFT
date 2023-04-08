function [bw, seg, wrn] = processImage(img, dense, internal)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: April 8, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: the image to convert
%       dense: true if a dense object is present, false otherwise
%             It adds more check to the segmentation to be able to recognize open lines and close dense lines.
%       internal: if true, the internal line is required (when segmentation of more than one pixel).
%
% OUTPUT:
%       bw: image converted to black and white
%       seg: segmentation of the object 
%       wrn: true if the input image had more than one channel but was not an rgb image: used only the first channel
%
% DESCRIPTION:
%       - Converts the image to 8 bit
%       - Convertes the image to black white
%       - Get the segmentation (perimeter) of the object contained in the image.
%       - CANNOT BE TRUE BOTH DENSE AND INTERNAL, if the object is dense there is no internal line.

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

    % Convert the image to bw
    bw = imbinarize(grayImg);

    % Convert to black background if needed
    if getBwBackground(bw)
        bw = ~bw;
    end

    % If there are more than one object, select the largest one
    [~, numBlobs] = bwlabel(bw);
    if numBlobs > 1
        bw = bwareafilt(bw, 1);
    end

    % Check line closing
    if ~checkClosedSegmentation(bw, dense)
        ME = MException('checkClosedSegmentation:openedSegmentation', 'Segmentation not closed');
        throw(ME);
    end

    % Check if the segmentation is empty
    if ~sum(bw(:))
        ME = MException('processImage:emptySegmentation', 'Segmentation empty');
        throw(ME);
    end

    % Check if the segmentation is already a single pixel 
    if isequal(bw, bwperim(bw))
        seg = bw;
        return; 
    end

    seg = getOnePixelSegmentation(bw, internal);
    
catch ME 
    % Rethrow the error
    % It will be catched by the gui
    rethrow(ME);
end

end