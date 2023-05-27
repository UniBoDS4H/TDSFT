% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 12, 2023
% NAME:   TDSFT (version 1.0)
%
% PARAMETERS:
%   - img (Matrix [height, width]):
%       image to convert.
%
% OUTPUT:
%   - cImg (Matrix [height, width]):
%       converted image.
%
% THROWS:
%   - 'TDSFT:processImage':
%       if the image is not converted to 8-bit.
% 
% DESCRIPTION:
%   Converts an image to 8-bit format.
%   Supported formats: 12-bit, 16-bit, 32-bit, 64-bit.
function cImg = imTo8bit(img)
    if isa(img, ImagesStoringMethods.INT_16.string)
        % 16-bit
        if max(img(:)) > 2^12 % 12-bit images are stored as 16-bit
            cImg  = uint8( 255.*double(img)./(2^16-1) ); 
        % 12-bit
        else
            cImg  = uint8( 255.*double(img)./(2^12-1) ); 
        end
    % 32-bit
    elseif isa(img, ImagesStoringMethods.INT_32.string)
        cImg  = uint8( 255.*double(img)./(2^32-1) );
    % 64-bit
    elseif isa(img, ImagesStoringMethods.INT_64.string)
        cImg  = uint8( 255.*double(img)./(2^64-1) );
    else
        cImg = img;
    end

    % Check if the storing method of the converted image is 'uint8'
    % else throws an error.
    if ~isa(cImg, ImagesStoringMethods.INT_8.string)
        throw(MException("TDSFT:processImage", "Image not converted to 8 bit"));
    end
end