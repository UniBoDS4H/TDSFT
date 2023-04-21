% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 12, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION: Enumeration class for images' storing methods.
classdef ImagesStoringMethods
    properties
        type
    end
    methods
        function storing_method = ImagesStoringMethods(m)
            storing_method.type = m;
        end
    end
    enumeration
        INT_8 ('uint8')
        INT_16 ('uint16')
        INT_32 ('uint32')
        INT_64 ('uint64')
    end

end

