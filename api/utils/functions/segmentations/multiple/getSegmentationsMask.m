function mask = getSegmentationsMask(segmentations)
    overlappedSegmentations = overlapSegmentations(segmentations);
    mask = getLargestArea(overlappedSegmentations);
end