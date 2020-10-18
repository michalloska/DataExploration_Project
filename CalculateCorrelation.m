function correlation = CalculateCorrelation(dataset1, dataset2)
    correlation = 0;
    startingDate = findCommonDataStartYear(dataset1, dataset2);
    endingDate = findCommonDataEndYear(dataset1, dataset2);

    % TODO: implement Matrix resizing so both matrices are same size for correllation calculation

% correllation = corrcoef(coalConsumptionData(2,2:size(coalConsumptionData,2)),hivData(2,2:size(coalConsumptionData,2)));

end

function commonstartYear = findCommonDataStartYear(dataset1, dataset2)
    commonstartYear = (min(dataset1{1,2}, dataset2{1,2}));
end

function commonEndYear = findCommonDataEndYear(dataset1, dataset2)
    dataset1Length = size(dataset1, 2);
    dataset2Length = size(dataset2, 2);
    commonEndYear = (min(dataset1{1,dataset1Length}, dataset2{1,dataset2Length}));
end
