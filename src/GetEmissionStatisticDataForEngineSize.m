function emissionData = GetEmissionStatisticDataForEngineSize(dataset, engineCapacityRange)
    co_emissions_column_number = 21;
    emissionData.engineSizes = zeros(length(engineCapacityRange)-1,1);
    emissionData.avgCoEmissionPerEngSize = zeros(length(engineCapacityRange)-1,1);
    emissionData.mean = mean(dataset{:,co_emissions_column_number}, 'omitnan');
    emissionData.std = std(dataset{:,co_emissions_column_number}, 'omitnan');

    [filteredData emissionData.foundOutliers] = RemoveOutliersFromCoEmissions(dataset);
    emissionData.stdFiltered = std(filteredData{:,co_emissions_column_number}, 'omitnan');

    % emissionData.filteredData = filteredData{:,co_emissions_column_number};

    for engineCapacity = 1:length(engineCapacityRange)-1
        lowerBound = dataset(dataset.engine_capacity >= engineCapacityRange(engineCapacity), :);
        filteredEngineCapacityCars = lowerBound(lowerBound.engine_capacity <= engineCapacityRange(engineCapacity+1), :);

        lowerBoundNoOutliers = filteredData(filteredData.engine_capacity >= engineCapacityRange(engineCapacity), :);
        filteredEngineCapacityCarsNoOutliers = lowerBoundNoOutliers(lowerBoundNoOutliers.engine_capacity <= engineCapacityRange(engineCapacity+1), :);

        % TODO:
        % Improve removal of outliers or implement from scratch for filteredEngineCapacityCars

        % IMPERFECT SOLUTION:
        %         filteredEngineCapacityCars = RemoveOutliersFromCoEmissions(filteredEngineCapacityCars, 'mean');
        % ------------------------------------------------------------------
        % REMOVING DATA FOR WHICH THE CO_EMISSION IS > 1000
        % filteredEngineCapacityCars = filteredEngineCapacityCars(filteredEngineCapacityCars.co_emissions <= 1000, :);

        emissionData.engineSizes(engineCapacity,2) = mean(engineCapacityRange(engineCapacity:engineCapacity+1), 'omitnan');
        emissionData.avgCoEmissionPerEngSize(engineCapacity,1) = mean(filteredEngineCapacityCars.co_emissions, 'omitnan');
        emissionData.filteredData(engineCapacity,1) = mean(filteredEngineCapacityCarsNoOutliers.co_emissions, 'omitnan');

    end
end
