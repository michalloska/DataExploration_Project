function [filteredData, foundBadDataSamples] = RemoveBadDataSamples(dataset, parameter)
    datasetLength = length(dataset{:,1});
    filteredData = dataset;
    foundBadDataSamples = [];
    if strcmp(parameter, 'co_emissons')
        co_emissions_column_number = 21;
        for row = 1:datasetLength
            currentElement_coEmissions = dataset{row,co_emissions_column_number};
            if or(currentElement_coEmissions < 0, currentElement_coEmissions > 10000)
                foundBadDataSamples = [foundBadDataSamples; currentElement_coEmissions];
                filteredData{row, co_emissions_column_number} = NaN;
            end
        end
    elseif strcmp(parameter, 'fuel_consumption')
        fuel_consumption_column_number = 14;
        engine_size_column_number = 10;
        for row = 1:datasetLength
            currentElement_fuelConsumption = dataset{row,fuel_consumption_column_number};
            currentElement_engineSize = dataset{row,engine_size_column_number};
            if currentElement_fuelConsumption < 0
                foundBadDataSamples = [foundBadDataSamples; currentElement_fuelConsumption];
                filteredData{row, fuel_consumption_column_number} = NaN;
            elseif and(currentElement_fuelConsumption > 15, currentElement_engineSize < 3000)
                foundBadDataSamples = [foundBadDataSamples; currentElement_fuelConsumption];
                filteredData{row, fuel_consumption_column_number} = NaN;
            end
        end
    end

end