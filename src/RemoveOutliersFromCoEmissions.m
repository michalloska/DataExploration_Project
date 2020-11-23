% https://de.mathworks.com/help/matlab/ref/rmoutliers.html
function filteredData = removeOutliersFromCoEmissions(dataset, modelFunction)
    co_emissions_column_number = 21;
    filteredData = dataset;
    filteredData = sortrows(filteredData, co_emissions_column_number);
    [filteredOutliers, RemovedIndices] = rmoutliers(dataset.co_emissions, modelFunction);

    if ~(size(RemovedIndices,1) ~= 0 && any( RemovedIndices(:,1) == 1 ))
        return;
    end

    for row = 1:length(RemovedIndices)
        if RemovedIndices(row) == 1
            filteredData.co_emissions(row) = NaN;
        end
    end
end
