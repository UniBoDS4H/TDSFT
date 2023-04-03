function res = algorithm_getLargestSegmentation(segmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: March 29, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations: the aligned segmentations to be fused together 
    %
    % OUTPUT:
    %       res: the resulting segmentation
    %
    % DESCRIPTION:
    %       Fuse all the segmentations together overlapping them and getting the smallest segmentation possible.
    %       The smallest segmentation is the one where are present the common parts from all the segmentations.  
    %
    
    disp('Getting the smallest segmentation...');


    % initialize the overlap
    first = segmentations{1};
    [m,n] = size(first);
    overlap = zeros(m, n, 'uint8');

    % overlap all the segmentations
    for i=1:length(segmentations)
        seg = uint8(segmentations{i});
        segFill = imfill(seg, 'holes');
        overlap = overlap + segFill;
    end 

    % select the common parts
    for i = 1:m
        for j = 1:n
            if overlap(i,j) == size(segmentations, 2)
                overlap(i,j) = 1;
            else
                overlap(i,j) = 0;
            end
        end
    end

    % get the perimeter
    res = bwperim(overlap);
end