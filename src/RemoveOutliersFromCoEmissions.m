% https://de.mathworks.com/help/matlab/ref/rmoutliers.html
function [filteredData, foundOutliers] = RemoveOutliersFromCoEmissions(dataset)
    co_emissions_column_number = 21;
    foundOutliers = [];
    filteredData = dataset;
    % filteredData = sortrows(filteredData, co_emissions_column_number);
    % [filteredOutliers, RemovedIndices] = rmoutliers(dataset.co_emissions);
    datasetLength = length(dataset{:,co_emissions_column_number});
    coEmissionMean = mean(dataset{:,co_emissions_column_number}, 'omitnan');
    coEmissionStd = std(dataset{:,co_emissions_column_number}, 'omitnan');

    for row = 1:datasetLength
        lowBound  = coEmissionMean - 3 * coEmissionStd;
        highBound = coEmissionMean + 3 * coEmissionStd;
        currentElement = dataset{row,co_emissions_column_number};
        if or(currentElement < lowBound, currentElement > highBound)
            foundOutliers = [foundOutliers; currentElement];
            % if currentElement > highBound
            if currentElement > 1500
                filteredData{row, co_emissions_column_number} = NaN;
            end
        end
    end

    % if ~(size(RemovedIndices,1) ~= 0 && any( RemovedIndices(:,1) == 1 ))
    %     return;
    % end

end
