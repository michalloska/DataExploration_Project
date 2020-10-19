function [dataset1Unified dataset2Unified] = UnifyDatasets(dataset1, dataset2, shouldRemoveCountryColumn)
    commonStartingDate = findCommonDataStartYear(dataset1, dataset2);
    commonEndingDate = findCommonDataEndYear(dataset1, dataset2);
    
    dataset1Unified = removeDatesOutOfScope(dataset1, commonStartingDate, commonEndingDate);
    dataset2Unified = removeDatesOutOfScope(dataset2, commonStartingDate, commonEndingDate);

    [dataset1Unified, dataset2Unified] = removeOddCountries(dataset1Unified, dataset2Unified);

    if shouldRemoveCountryColumn == true
        dataset1Unified = removeCountryColumn(dataset1Unified);
        dataset2Unified = removeCountryColumn(dataset2Unified);
    end
end

