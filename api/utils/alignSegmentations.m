function res = alignSegmentations(segmentations) 
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: March 24, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       segmentations: the segmentations to align 
    %
    % OUTPUT:
    %       res: the aligned segmentations
    %
    % DESCRIPTION:
    %       Align all the segmentations.
    %
    
    first = [];
    res = {};

    for i = 1:length(segmentations)
        seg = segmentations{i};
        % Get the first segmentation and center it
        if isempty(first)
            first = seg;
            first = centerSegmentation(first);
            res = [res, first];  

        % Else align others to the first one
        else

            [optimizer,metric] = imregconfig("multimodal");
            tSeg = imregister(uint8(seg), uint8(first), "similarity", optimizer, metric);
            figure, imshow(tSeg, []);
            res = [res, tSeg];
    
        end
    end    

end