function overlap = overlapSegmentations(segmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: April 11, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations: the segmentations to overlap 
    %
    % OUTPUT:
    %       overlap: the overlapped segmentations
    %
    % DESCRIPTION:
    %       Overlap the segmentations in the input array and return the resulting matrix.  
    

    if isempty(segmentations)
        ME = MException('overlapSegmentations:emptyInput', 'Segmentations array empty');
        throw(ME);
        return;
    end

    if length(segmentations) == 1
        res = segmentations{1};
        return;
    end

    % initialize the overlap
    first = segmentations{1};
    [m,n] = size(first);
    overlap = zeros(m, n, 'uint8');

    % overlap all the segmentations
    for i=1:length(segmentations)
        seg = uint8(segmentations{i});
        overlap = overlap + seg;
    end 
end