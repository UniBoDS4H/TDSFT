function check = isSegmentationClosed(img, flag)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img (Matrix [height, width]):
%           black and white image.
%
%       flag (boolean):
%           true if a dense object is present and you want more tests, false otherwise.
%           It adds more check to the segmentation to be able to recognize open lines and close dense lines.
%
% OUTPUT:
%       check:
%           true (1) => Line closed 
%           false (0) => Line opened
%
% DESCRIPTION:
%       Checks if the segmentation is closed or not. Returns true if it is closed


    imgFill = imfill(img,'holes');
    dif1 = imgFill - img;
    if sum(sum(dif1)) ~= 0
        check = true;
    else
        % Check if it is an open segmentation of 1 pixel
        perim = bwperim(img);
        check = ~isequal(perim, img);

        if ~check || ~flag
            return;
        end

        % If it is a dense object make an easy empirical test.
        % ATTENTION: it is not a perfect check since it is not possible to separate a dense object (close dense line)
        %            from a line of more than one pixel.
        fillCells = nnz(imgFill);
        perimCells = nnz(perim);

        check = fillCells > 2 * perimCells;
    end

end