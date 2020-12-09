function fuelConsumptionData = GetFuelConsumptionStatisticDataForEngineSize(dataset, engineCapacityRange)
    fuel_consumption_column_number = 14;
    fuelConsumptionData.engineSizes = zeros(length(engineCapacityRange)-1,1);
    fuelConsumptionData.avgFuelConsumptionPerEngSize = zeros(length(engineCapacityRange)-1,1);
    fuelConsumptionData.mean = mean(dataset{:,fuel_consumption_column_number}, 'omitnan');
    fuelConsumptionData.std = std(dataset{:,fuel_consumption_column_number}, 'omitnan');

    [filteredData fuelConsumptionData.foundOutliers] = RemoveOutliersFromFuelConsumption(dataset, 0);
    fuelConsumptionData.stdFiltered = std(filteredData{:,fuel_consumption_column_number}, 'omitnan');

    for engineCapacity = 1:length(engineCapacityRange)-1
        currentEngCap = engineCapacityRange(engineCapacity);
        lowerBound = dataset(dataset.engine_capacity >= engineCapacityRange(engineCapacity), :);
        filteredEngineCapacityCars = lowerBound(lowerBound.engine_capacity < engineCapacityRange(engineCapacity+1), :);

        lowerBoundNoOutliers = filteredData(filteredData.engine_capacity >= engineCapacityRange(engineCapacity), :);
        filteredEngineCapacityCarsNoOutliers = lowerBoundNoOutliers(lowerBoundNoOutliers.engine_capacity < engineCapacityRange(engineCapacity+1), :);

        fuelConsumptionData.engineSizes(engineCapacity,2) = mean(engineCapacityRange(engineCapacity:engineCapacity+1), 'omitnan');
        fuelConsumptionData.avgFuelConsumptionPerEngSize(engineCapacity,1) = mean(filteredEngineCapacityCars.combined_metric, 'omitnan');
        fuelConsumptionData.filteredData(engineCapacity,1) = mean(filteredEngineCapacityCarsNoOutliers.combined_metric, 'omitnan');
    end
end
