% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: March 17, 2023
% NAME: TDSFT (version 1.0)
%
% DESCRIPTION:
% This function is used to add the folders of the project to the Matlab search path.
% It is necessary for running the project inside appdesigner.
function runStartup() 
    addpath(genpath("."));
end