% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: May 8, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION: Enumeration class for one pixel line types.
%              Used to specify which one pixel line the user 
%              wants to use if the segmentation is of more than one pixel.
classdef OnePixelLineTypes
    properties
        string
    end

    methods
        % Constructor
        %
        % Parameters:
        %   s: string representing the type of the image
        % Return:
        %   the one pixel line type
        function line_type = OnePixelLineTypes(s)
            line_type.string = s;
        end
    end

    % Enumeration values with their corresponding string
    enumeration
        EXTERNAL ('external')
        MIDDLE ('middle')
        INTERNAL ('internal')
    end
end

