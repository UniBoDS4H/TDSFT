function cImg = imTo8bit(img)
% AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
% DATE: March 15, 2022
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       img: image to convert.
%
% OUTPUT:
%       cImg: converted image.
%
% THROWS:
%       Error if the image is not converted to 8 bit.
% 
% DESCRIPTION:
%      Converts an image to 8-bit format.

if isa(img, ImagesStoringMethods.INT_16)
    if max(img(:)) > 2^12
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
if ~isa(cImg, ImagesStoringMethods.INT_8)
    ME = MException('imTo8bit:notConverted', 'Image not converted to 8 bit');
    throw(ME);
end

end