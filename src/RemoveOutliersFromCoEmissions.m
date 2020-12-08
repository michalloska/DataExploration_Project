function [filteredData, foundOutliers] = RemoveOutliersFromCoEmissions(dataset, trueSigma)
    co_emissions_column_number = 21;
    foundOutliers = [];
    filteredData = dataset;
    datasetLength = length(dataset{:,co_emissions_column_number});
    coEmissionMean = mean(dataset{:,co_emissions_column_number}, 'omitnan');
    coEmissionStd = std(dataset{:,co_emissions_column_number}, 'omitnan');

    for row = 1:datasetLength
        lowBound  = coEmissionMean - 3 * coEmissionStd;
        highBound = coEmissionMean + 3 * coEmissionStd;
        currentElement = dataset{row,co_emissions_column_number};
        if or(currentElement < lowBound, currentElement > highBound)
            foundOutliers = [foundOutliers; currentElement];
            if currentElement > 69000
                filteredData{row, co_emissions_column_number} = NaN;
            end
            if trueSigma == 1
                if currentElement > highBound
                    filteredData{row, co_emissions_column_number} = NaN;
                end
            else
                if currentElement > 1200
                    filteredData{row, co_emissions_column_number} = NaN;
                end
            end
        end
    end
end
