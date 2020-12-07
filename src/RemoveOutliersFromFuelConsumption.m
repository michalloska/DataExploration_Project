function [filteredData, foundOutliers] = RemoveOutliersFromCoEmissions(dataset, trueSigma)
    fuel_consumption_column_number = 14;
    foundOutliers = [];
    filteredData = dataset;
    datasetLength = length(dataset{:,fuel_consumption_column_number});
    coEmissionMean = mean(dataset{:,fuel_consumption_column_number}, 'omitnan');
    coEmissionStd = std(dataset{:,fuel_consumption_column_number}, 'omitnan');

    for row = 1:datasetLength
        lowBound  = coEmissionMean - 3 * coEmissionStd;
        highBound = coEmissionMean + 3 * coEmissionStd;
        currentElement = dataset{row,fuel_consumption_column_number};
        if or(currentElement < lowBound, currentElement > highBound)
            foundOutliers = [foundOutliers; currentElement];
            if trueSigma == 1
                if currentElement > highBound
                    filteredData{row, fuel_consumption_column_number} = NaN;
                end
            else
                if currentElement > 1500
                    filteredData{row, fuel_consumption_column_number} = NaN;
                end
            end
        end
    end
end
