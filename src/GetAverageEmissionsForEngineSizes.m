function averageEmissions = GetAverageEmissionsForEngineSizes(dataset, engineCapacityRange)
    averageEmissions = zeros(length(engineCapacityRange)-1,2);

    for engineCapacity = 1:length(engineCapacityRange)-1
        lowerBound = dataset(dataset.engine_capacity >= engineCapacityRange(engineCapacity), :);
        filteredEngineCapacityCars = lowerBound(lowerBound.engine_capacity <= engineCapacityRange(engineCapacity+1), :);

        % TODO:
        % Improve removal of outliers or implement from scratch for filteredEngineCapacityCars
        % IMPERFECT SOLUTION:
        [filteredOutliers, RemovedIndices] = rmoutliers(filteredEngineCapacityCars.co_emissions, 'median');

        if size(RemovedIndices,1) ~= 0 && any( RemovedIndices(:,1) == 1 )
            filteredEngineCapacityCars = removeOutliersFromCoEmissions(filteredEngineCapacityCars, RemovedIndices);
        end
        % ------------------------------------------------------------------
        averageEmissions(engineCapacity,2) = mean(engineCapacityRange(engineCapacity:engineCapacity+1));
        averageEmissions(engineCapacity,1) = mean(filteredEngineCapacityCars.co_emissions);

    end
end

function filteredData = removeOutliersFromCoEmissions(dataset, indices)
    for row = 1:length(indices)
        if indices(row) == 1
            dataset.co_emissions(row) = NaN;
        end
    end
    filteredData = dataset;
end