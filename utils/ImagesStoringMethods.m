% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   April 20, 2023
% NAME:   TDSFT (version 1.0)
%
% Enumeration class for image storing methods.
% Used to be able to use pretty names for 
% the different storing methods.
classdef ImagesStoringMethods
    properties
        string % string representation of the storing method
    end

    methods
        function storing_method = ImagesStoringMethods(s)
            % Constructor
            %
            % Parameters:
            %   s:string representing the type of the image
            % Return:
            %   the image storing method

            storing_method.string = s;
        end
    end

    % Enumeration values with their corresponding string.
    enumeration
        INT_8 ("uint8")   % 8-bit image
        INT_16 ("uint16") % 16-bit image
        INT_32 ("uint32") % 32-bit image
        INT_64 ("uint64") % 64-bit image
    end
end

