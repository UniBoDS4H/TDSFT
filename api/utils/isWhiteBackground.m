function check = isWhiteBackground(img)
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
    % DATE: April 12, 2023
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       img (Matrix [height, width]):
    %           black and white image
    % OUTPUT:
    %       check: 
    %           true (1) => white
    %           false (0) => black)
    %  
    % DESCRIPTION:
    %       Returns the background of a black and white image.

        [h, w] = size(img);

        b1 = sum( img(1, :) );
        b2 = sum( img(h, :) );
        b3 = sum( img(:, 1) );
        b4 = sum( img(:, w) );

        check = b1 && b2 && b3 && b4;
end