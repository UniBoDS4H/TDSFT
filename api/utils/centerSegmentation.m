function res = centerSegmentation(seg)
    % AUTHOR: Lorenzo Drudi (E-mail: lorenzo.drudi5@studio.unibo.it)
    % DATE: March 24, 2022
    % NAME: TDSFT (version 1.0)
    %
    % PARAMETERS:
    %       seg: the segmentations to center 
    %
    % OUTPUT:
    %       res: the centered segmentation
    %
    % DESCRIPTION:
    %       Center the input segmentation.
    %
    
    % Get bounding box of the object
    stats = regionprops(seg, 'BoundingBox');
    % We get the first one assuming that in the image there is only one object.
    bbox = stats(1).BoundingBox;

    % Get the center of the bounding box
    center_x = bbox(1) + bbox(3) / 2;
    center_y = bbox(2) + bbox(4) / 2;

    % Get image size
    [rows, cols, ~] = size(seg);

    % Compute the translation needed to center the segmentation
    dx = round(cols / 2 - center_x);
    dy = round(rows / 2 - center_y);

    % Shift the segmentation
    res = imtranslate(seg, [dx, dy]);
end