function [dataset1Unified dataset2Unified] = UnifyDatasets(dataset1, dataset2, shouldRemoveCountryColumn)
    commonStartingDate = findCommonDataStartYear(dataset1, dataset2);
    commonEndingDate   = findCommonDataEndYear(dataset1, dataset2);

    dataset1Unified = removeDatesOutOfScope(dataset1, commonStartingDate, commonEndingDate);
    dataset2Unified = removeDatesOutOfScope(dataset2, commonStartingDate, commonEndingDate);

    [dataset1Unified, dataset2Unified] = removeOddCountries(dataset1Unified, dataset2Unified);

    if shouldRemoveCountryColumn == true
        dataset1Unified = removeCountryColumn(dataset1Unified);
        dataset2Unified = removeCountryColumn(dataset2Unified);
    end
end

function commonstartYear = findCommonDataStartYear(dataset1, dataset2)
    commonstartYear = (max(dataset1{1,2}, dataset2{1,2}));
end

function commonEndYear = findCommonDataEndYear(dataset1, dataset2)
    dataset1Length = size(dataset1, 2);
    dataset2Length = size(dataset2, 2);
    commonEndYear = (min(dataset1{1,dataset1Length}, dataset2{1,dataset2Length}));
end

function resizedDataset = removeDatesOutOfScope(dataset1, startingYear, endYear)
    secondColumn = 2;

    while dataset1{1,secondColumn} < startingYear
        dataset1(:,secondColumn) = [];
    end

    j = size(dataset1, 2);
    while dataset1{1,j} > endYear
        dataset1(:,j) = [];
        j = j - 1;
    end

    resizedDataset = dataset1;
end

function matrixNoCountryColumn = removeCountryColumn(dataset1)
    matrixNoCountryColumn = dataset1{:,2:size(dataset1,2)};
end

function [filteredDataset1 filteredDataset2] = removeOddCountries(dataset1, dataset2)
    dataset1Length = size(dataset1,1);
    dataset2Length = size(dataset2,1);
    
    filteredDataset1 = dataset1;
    filteredDataset2 = dataset2;
    
    
    
    for i = 2:dataset1Length-2
        found = false;
        for j = 2:dataset2Length-2
            tempI = dataset1{i,1};
            tempJ = dataset2{j,1};
            if strcmp(dataset1{i,1}, dataset2{j,1})
                found = true;
                break;
            end
            found = false;
        end
        if found == false
            filteredDataset1(i,:) = [];
        end
    end
end

% function contains = countriesOccurInBothDatasets(dataset1, dataset2)