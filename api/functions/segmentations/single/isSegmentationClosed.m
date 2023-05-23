% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 12, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - img (Matrix [height, width]):
%       black and white image.
%   - flag (boolean):
%       true if a dense object is present and more tests are required, false otherwise.
%       It adds more checks to the segmentation to be able to better recognize open lines and close dense lines.
%       Be careful, it is difficult to recognize a dense object from an open line of more than one pixel.
%       Since an open line of more than one pixel is, by definition, a dense object we use some statistics to
%       recognize a dense object from an open line of more than one pixel.
%       So if you are not sure that the object is dense, set dense to false.
%
% OUTPUT:
%   - check:
%      true (1) => Line closed 
%      false (0) => Line opened
%
% DESCRIPTION:
%   Checks if the segmentation is closed or not. Returns true if it is closed.
function check = isSegmentationClosed(img, flag)
    imgFill = imfill(img, "holes");

    % If the image can be filled it means the object in the image is not dense
    % and there is a hole to fill so the segmentation is closed.
    if ~isequal(img, imgFill)
        check = true;
    else
        % Here there are two options:
        % 1) The object in the image is a dense object;
        % 2) The object in the image is an open line of more than one pixel.

        % Check if it is an open segmentation of 1 pixel.
        perim = bwperim(img);
        check = ~isequal(perim, img);

        if ~check || ~flag
            return;
        end

        % If dense option is true do a statistical test to check to recognize a dense object from an open line of more than one pixel.
        % ATTENTION: it is not a perfect check since it is not possible to separate a dense object (close dense line)
        %            from a line of more than one pixel.
        fillCells = nnz(imgFill);
        perimCells = nnz(perim);

        check = fillCells > 2 * perimCells;
    end

end