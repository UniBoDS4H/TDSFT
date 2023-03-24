function [cImg, bw, seg] = processImage(img, flag)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 20, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: the image to convert
%       flag: true if a dense object is present, false otherwise
%             It adds more check to the segmentation to be able to recognize open lines and close dense lines.
%
% OUTPUT:
%       cImg: image converted to 8 bit
%       bw: image converted to black and white
%       seg: segmentation of the object 
%
% DESCRIPTION:
%       - Converts the image to 8 bit
%       - Convertes the image to black white
%       - Get the segmentation (perimeter) of the object contained in the image.

% Check the channels of the image
% If the image has more than one channel but is not an rgb image, use only the first one
if size(img,3) ~= 1 && size(img,3) ~= 3
    img = img(:,:,1);
    waitfor( warndlg("Used only the first channel of the image") ); % Wait until ok is pressed
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
    if ~checkClosedSegmentation(bw, flag)
        ME = MException('checkClosedSegmentation:openedSegmentation', 'Segmentation not closed');
        throw(ME);
    end

    seg = getSegmentation(bw);

catch ME 
    % Rethrow the error
    % It will be catched by the gui
    rethrow(ME);
end

end