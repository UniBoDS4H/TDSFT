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

        [r, c] = size(img);

        b1 = img(1, round(c/2));
        b2 = img(r, round(c/2));
        b3 = img(round(r/2), 1);
        b4 = img(round(r/2), c);

        check = b1 && b2 && b3 && b4;
end