function imTo8bit(img)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 15, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: the image to convert

% OUTPUT:
%       cImg: the converted image

% TODO: check im2uint8 (the docs says it works only with uint16).
if isa(img, ImagesStoringMethods.INT_16)
    if max(newImg(:)) > 2^12
        cImg  = 255.*double(img)./(2^16-1); 
    else
        cImg  = 255.*double(img)./(2^12-1); 
    end
elseif isa(img, ImagesStoringMethods.INT_32)
    cImg  = 255.*double(img)./(2^32-1);
elseif isa(img, ImagesStoringMethods.INT_64)
    cImg  = 255.*double(img)./(2^64-1);
else
    cImg = img;
end

% Check if the storing method of the converted image is `uint8`
if ~isa(cImg, ImagesStoringMethods.UINT_8)
    error('Error. \nThe image is not uint8');
end

end