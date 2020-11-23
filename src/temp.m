a = [ 100; 100; 70000; 70000; 133; 133; 100];
% [filteredOutliers, RemovedIndices] = rmoutliers(a, 'percentiles', [30, 70]);
[filteredOutliers, RemovedIndices] = rmoutliers(a,'median');

% RemovedElements = filteredEngineCapacityCars.co_emissions(RemovedIndices);