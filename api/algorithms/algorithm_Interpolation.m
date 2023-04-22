% AUTHOR: Lorenzo Drudi (E-mail: lorenzodrudi11@gmail.com)
% DATE: April 22, 2023
% NAME: TDSFT (version 1.0)
%
% PARAMETERS:
%       segmentations (Cell array: [1, raters] (Cells: matrix [height, width]):
%           The array where each element is a segmentation. 
%       mainSegmentation (int):
%           The index of the segmentation to be used as main segmentation.
%
% OUTPUT:
%   TODO       
%
% THROWS:
%   TODO
%
% DESCRIPTION:
%   TODO
function res = algorithm_Interpolation(segmentations, mainSegmentation)
    % Check if the input is empty
    if isempty(segmentations)
        ME = MException('interpolateSegmentations:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    nSeg = length(segmentations);
    
    % If there is only one segmentation, return it
    if nSeg == 1
        smallestSegmentation = segmentations{1};
        return;
    end

    % L'idea e' semplice. Prendiamo la segmentazione prescelta (la main) e per ogni pixel a 1 prendiamo il pixel a 1 pie' vicino
    % di ogni altra segmentazione. A questo punto uniamo i punti:
     % - se le segmentazioni sono solo due otteniamo un segmento di cui bastera' prendere il punto medio
     % - se le segmentazioni sono piu' di due, prendiamo il baricentro della figura che si forma con i punti

    % Get the main segmentation
    mainSeg = segmentations{mainSegmentation};

    % Get the size of the main segmentation
    [height, width] = size(mainSeg);

    % Create the output segmentation
    res = zeros(height, width);

    % For each pixel of the main segmentation
    try 
        for i = 1:height
            for j = 1:width

                % If the pixel is a 1
                if mainSeg(i, j) == 1

                    % Get the nearest pixel of the other segmentations
                    nearestPixels = zeros(nSeg, 2);
                    for k = 1:nSeg
                        if k ~= mainSegmentation
                            nearestPixels(k, :) = getNearestPixel(segmentations{k}, i, j);
                        end
                    end

                    % Get the cenroid of the points
                    [x, y] = getCentroid(nearestPixels);

                    % Set the pixel to 1
                    res(x, y) = 1;
                end
            end
        end
    catch ME
        rethrow(ME);
    end
end