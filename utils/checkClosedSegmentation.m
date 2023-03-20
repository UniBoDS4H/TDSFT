function check = checkClosedSegmentation(img, flag)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 17, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: black and white image
%       flag: true if there is at least one dense object

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
        check = ~(perim == img);

        if flag
            % TODO: Check using perimeter if it's dense or just opened
        end
    end

end