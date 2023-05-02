% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION: Enumeration class for image storing methods.
%              It is used to be able to use pretty names for 
%              the different storing methods.
classdef ImagesStoringMethods
    properties
        type
    end

    methods
        % Constructor
        %
        % Parameters:
        %   m: string representing the type of the image
        function storing_method = ImagesStoringMethods(m)
            storing_method.type = m;
        end
    end

    % Enumeration values with their corresponding string
    enumeration
        INT_8 ("uint8")
        INT_16 ("uint16")
        INT_32 ("uint32")
        INT_64 ("uint64")
    end
end

