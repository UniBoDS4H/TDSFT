% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 20, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION: Enumeration class for image storing methods.
%              Used to be able to use pretty names for 
%              the different storing methods.
classdef ImagesStoringMethods
    properties
        string
    end

    methods
        % Constructor
        %
        % Parameters:
        %   s: string representing the type of the image
        % Return:
        %   the image storing method
        function storing_method = ImagesStoringMethods(s)
            storing_method.string = s;
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

