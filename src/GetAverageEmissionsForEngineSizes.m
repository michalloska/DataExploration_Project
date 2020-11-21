function averageEmissions = GetAverageEmissionsForEngineSizes(dataset, engineCapacityRange)
    averageEmissions = zeros(length(engineCapacityRange)-1,2);

    for engineCapacity = 1:length(engineCapacityRange)-1
        lowerBound = dataset(dataset.engine_capacity >= engineCapacityRange(engineCapacity), :);
        filteredEngineCapacityCars = lowerBound(lowerBound.engine_capacity <= engineCapacityRange(engineCapacity+1), :);

        % TODO:
        % ADD VALIDATION FOR ATYPICAL ELEMETNS IN filteredEngineCapacityCars
        % TEMPORARY SOLUTION:
        filteredEngineCapacityCars = filteredEngineCapacityCars(filteredEngineCapacityCars.co_emissions <= 3000, :);
        % ------------------------------------------------------------------
        averageEmissions(engineCapacity,2) = mean(engineCapacityRange(engineCapacity:engineCapacity+1));
        averageEmissions(engineCapacity,1) = mean(filteredEngineCapacityCars.co_emissions);

    end
end