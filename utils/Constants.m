% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE:   May 19, 2023
% NAME:   TDSFT (version 1.0)
%
% DESCRIPTION:
%   Class containing the constants used in the project.
classdef Constants
    properties (Constant)
        % The root of the algorithm names.
        ALGORITHM_NAMES_FILE_ROOT = "fusion_";

        % The root of the closing algorithm names.
        CLOSING_NAMES_FILE_ROOT = "closing_";

        % The extension of source files.
        SRC_EXTENSION = ".m";

        % The file extension for the input files.
        INPUT_FILE_EXTENSION = ".json";
    end
end