function [cImg, bw, seg] = processImage(img)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 20, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: the image to convert

% OUTPUT:
%       bw: image converted to black and white
%       seg: segmentation of the object 

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

    % Check line closing
    if ~checkClosedSegmentation(bw);
        ME = MException('checkClosedSegmentation:openedSegmentation', 'Segmentation not closed');
        throw(ME);
        uialert(app.UIFigure, 'Error', 'The line is not closed. \nImage discarded');
    end

    seg = getSegmentation(bw);

catch ME 
    % Rethrow the error
    % It will be catched by the gui
    rethrow(ME);
end

end