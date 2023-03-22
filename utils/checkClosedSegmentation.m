function check = checkClosedSegmentation(img, flag)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 17, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: black and white image
%       flag: true if a dense object is present, false otherwise
%             It adds more check to the segmentation to be able to recognize open lines and close dense lines.
%
% OUTPUT:
%       true => Line closed 
%       false => Line opened
%
% DESCRIPTION:
%       Checks if the segmentation is closed or not.
% 

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