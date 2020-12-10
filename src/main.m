% 2020
% Adrian Wysocki
% Michal Loska

clc
clear
clfall

carEmissionsDatasetPath = '../data/carEmissions.csv';
imgSavePath = '../diagrams/';
carEmissionsDataset = readtable(carEmissionsDatasetPath);

[carEmissionsDataset, carEmissionsDataset_badCoEmissons] = RemoveBadDataSamples(carEmissionsDataset, 'co_emissons');
[carEmissionsDataset, carEmissionsDataset_badFuelConsumption] = RemoveBadDataSamples(carEmissionsDataset, 'fuel_consumption');

allAutomaticCars = GetTransmissionType(carEmissionsDataset, 'Automatic');
allManualCars    = GetTransmissionType(carEmissionsDataset, 'Manual');

allPetrolAutomaticCars = GetCarsByFuelType('Petrol', allAutomaticCars);
allDieselAutomaticCars = GetCarsByFuelType('Diesel', allAutomaticCars);
allPetrolManualCars    = GetCarsByFuelType('Petrol', allManualCars);
allDieselManualCars    = GetCarsByFuelType('Diesel', allManualCars);


% SORT BY CO EMISSIONS
% co_emissions_column_number = 21;
%
% allPetrolAutomaticCars = sortrows(allPetrolAutomaticCars, co_emissions_column_number);
% allDieselAutomaticCars = sortrows(allDieselAutomaticCars, co_emissions_column_number);
% allPetrolManualCars    = sortrows(allPetrolManualCars, co_emissions_column_number);
% allDieselManualCars    = sortrows(allDieselManualCars, co_emissions_column_number);

% REMOVE OUTLIERS FROM THE WHOLE SET
% modelMethod = 'median';

% allPetrolAutomaticCars = RemoveOutliersFromCoEmissions(allPetrolAutomaticCars, modelMethod);
% allDieselAutomaticCars = RemoveOutliersFromCoEmissions(allDieselAutomaticCars, modelMethod);
% allPetrolManualCars    = RemoveOutliersFromCoEmissions(allPetrolManualCars, modelMethod);
% allDieselManualCars    = RemoveOutliersFromCoEmissions(allDieselManualCars, modelMethod);

engineCapacityRange = [50:100:5000];

figure(1);
histogram(allPetrolAutomaticCars.engine_capacity, engineCapacityRange);
title('Petrol automatic cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
print(['-f' num2str(1)],[imgSavePath num2str(1) '_' 'Petrol automatic cars'],'-dpng');

figure(2);
histogram(allDieselAutomaticCars.engine_capacity, engineCapacityRange);
title('Diesel automatic cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
print(['-f' num2str(2)],[imgSavePath num2str(2) '_' 'Diesel automatic cars'],'-dpng');
figure(3);
histogram(allPetrolManualCars.engine_capacity, engineCapacityRange);
title('Petrol manual cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
print(['-f' num2str(3)],[imgSavePath num2str(3) '_' 'Petrol manual cars'],'-dpng');
figure(4);
histogram(allDieselManualCars.engine_capacity, engineCapacityRange);
title('Diesel manual cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
print(['-f' num2str(4)],[imgSavePath num2str(4) '_' 'Diesel manual cars'],'-dpng');


PetrolAutomaticData = GetEmissionStatisticDataForEngineSize(allPetrolAutomaticCars, engineCapacityRange);
DieselAutomaticData = GetEmissionStatisticDataForEngineSize(allDieselAutomaticCars, engineCapacityRange);
PetrolManualData    = GetEmissionStatisticDataForEngineSize(allPetrolManualCars, engineCapacityRange);
DieselManualData    = GetEmissionStatisticDataForEngineSize(allDieselManualCars, engineCapacityRange);

allPetrolCars = GetCarsByFuelType('Petrol', carEmissionsDataset);
allDieselCars = GetCarsByFuelType('Diesel', carEmissionsDataset);
PetrolCarsData = GetFuelConsumptionStatisticDataForEngineSize(allPetrolCars, engineCapacityRange);
DieselCarsData = GetFuelConsumptionStatisticDataForEngineSize(allDieselCars, engineCapacityRange);

bothFuelCars = [PetrolCarsData.avgFuelConsumptionPerEngSize(:,1)';...
                DieselCarsData.avgFuelConsumptionPerEngSize(:,1)']

figure(11);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), bothFuelCars);
title('Engine Capacity vs Fuel Consumption');
xlabel('Engine Capcity [cm^3]');
ylabel('Fuel Consumption [L/100km]');
legend(["Petrol",...
        "Diesel"
        ])
hold off;
print(['-f' num2str(11)],[imgSavePath num2str(11) '_' 'Engine Capacity vs Fuel Consumption'],'-dpng');

allCars = [PetrolAutomaticData.avgCoEmissionPerEngSize(:,1)';...
           DieselAutomaticData.avgCoEmissionPerEngSize(:,1)';...
           PetrolManualData.avgCoEmissionPerEngSize(:,1)';...
           DieselManualData.avgCoEmissionPerEngSize(:,1)'];

figure(5);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), allCars);
title('Average emissions for engine capacities with Outliers');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Petrol Automatic",...
        "Diesel Automatic",...
        "Petrol Manual",...
        "Diesel Manual"
        ])
hold off;
print(['-f' num2str(5)],[imgSavePath num2str(5) '_' 'Average emissions for engine capacities with Outliers'],'-dpng');


figure(7);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), PetrolAutomaticData.avgCoEmissionPerEngSize(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), PetrolAutomaticData.filteredData(:,1)');
plot(xlim, [1 1]*PetrolAutomaticData.mean, '--k')
plot(xlim, [1 1]*PetrolAutomaticData.mean-PetrolAutomaticData.stdFiltered*3, '--k')
plot(xlim, [1 1]*PetrolAutomaticData.mean+PetrolAutomaticData.stdFiltered*3, '--k')
title('Average emissions for Petrol Automatic');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Petrol Automatic",...
        "Petrol Automatic No Outliers"
        ])
hold off;
print(['-f' num2str(7)],[imgSavePath num2str(7) '_' 'Average emissions for Petrol Automatic'],'-dpng');

figure(8);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), DieselAutomaticData.avgCoEmissionPerEngSize(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), DieselAutomaticData.filteredData(:,1)');
plot(xlim, [1 1]*DieselAutomaticData.mean, '--k')
plot(xlim, [1 1]*DieselAutomaticData.mean-DieselAutomaticData.stdFiltered*3, '--k')
plot(xlim, [1 1]*DieselAutomaticData.mean+DieselAutomaticData.stdFiltered*3, '--k')
title('Average emissions for Diesel Automatic');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Diesel Automatic",...
        "Diesel Automatic No Outliers"
        ])
hold off;
print(['-f' num2str(8)],[imgSavePath num2str(8) '_' 'Average emissions for Diesel Automatic'],'-dpng');

allCarsNoOutliers = [PetrolAutomaticData.filteredData(:,1)';...
                     DieselAutomaticData.filteredData(:,1)';...
                     PetrolManualData.filteredData(:,1)';...
                     DieselManualData.filteredData(:,1)'];

figure(9);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), PetrolManualData.avgCoEmissionPerEngSize(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), PetrolManualData.filteredData(:,1)');
plot(xlim, [1 1]*PetrolManualData.mean, '--k')
plot(xlim, [1 1]*PetrolManualData.mean-PetrolManualData.stdFiltered*3, '--k')
plot(xlim, [1 1]*PetrolManualData.mean+PetrolManualData.stdFiltered*3, '--k')
title('Average emissions for Petrol Manual');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Petrol Manual",...
        "Petrol Manual No Outliers"
        ])
hold off;
print(['-f' num2str(9)],[imgSavePath num2str(9) '_' 'Average emissions for Petrol Manual'],'-dpng');

figure(10);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), DieselManualData.avgCoEmissionPerEngSize(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), DieselManualData.filteredData(:,1)');
plot(xlim, [1 1]*DieselManualData.mean, '--k')
plot(xlim, [1 1]*DieselManualData.mean-DieselManualData.stdFiltered*3, '--k')
plot(xlim, [1 1]*DieselManualData.mean+DieselManualData.stdFiltered*3, '--k')
title('Average emissions for Diesel Manual');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Diesel Manual",...
        "Diesel Manual No Outliers"
        ])
hold off;
print(['-f' num2str(10)],[imgSavePath num2str(10) '_' 'Average emissions for Diesel Manual'],'-dpng');

figure(6);
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), allCarsNoOutliers);
title('Average emissions for engine capacities without Outliers');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Petrol Automatic",...
        "Diesel Automatic",...
        "Petrol Manual",...
        "Diesel Manual"])
print(['-f' num2str(6)],[imgSavePath num2str(6) '_' 'Average emissions for engine capacities without Outliers'],'-dpng');

germanCars   = ["Audi", "BMW", "Volkswagen", "Mercedes-Benz", "Skoda", "Seat"];
frenchCars   = ["Peugeot", "Citroen", "Renault"];
japaneseCars = ["Nissan", "Mitsubishi", "Suzuki", "Toyota", "Mazda", "Honda"];
italianCars  = ["Fiat", "Alfa Romeo"];

germanCarsData = GetDataByCarBrand(carEmissionsDataset, germanCars);
germanCarsDataStatistics = GetEmissionStatisticDataForEngineSize(germanCarsData, engineCapacityRange);

frenchCarsData = GetDataByCarBrand(carEmissionsDataset, frenchCars);
frenchCarsDataStatistics = GetEmissionStatisticDataForEngineSize(frenchCarsData, engineCapacityRange);

japaneseCarsData = GetDataByCarBrand(carEmissionsDataset, japaneseCars);
japaneseCarsDataStatistics = GetEmissionStatisticDataForEngineSize(japaneseCarsData, engineCapacityRange);

italianCarsData = GetDataByCarBrand(carEmissionsDataset, italianCars);
italianCarsDataStatistics = GetEmissionStatisticDataForEngineSize(italianCarsData, engineCapacityRange);

figure(12);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), germanCarsDataStatistics.filteredData(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), frenchCarsDataStatistics.filteredData(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), japaneseCarsDataStatistics.filteredData(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), italianCarsDataStatistics.filteredData(:,1)');
title('Average emissions for different Countries');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["German Cars",...
        "French Cars",...
        "Japanese Cars",...
        "Italian Cars"])
hold off;
print(['-f' num2str(12)],[imgSavePath num2str(12) '_' 'Average emissions for different Countries'],'-dpng');

figure(13);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), germanCarsDataStatistics.filteredData(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), frenchCarsDataStatistics.filteredData(:,1)');
title('French vs German Cars');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["German Cars",...
        "French Cars"])
hold off;
print(['-f' num2str(13)],[imgSavePath num2str(13) '_' 'French vs German Cars'],'-dpng');

figure(14);
hold on;
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), germanCarsDataStatistics.filteredData(:,1)');
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), japaneseCarsDataStatistics.filteredData(:,1)');
title('Japanese vs German Cars');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["German Cars",...
        "Japanese Cars"])
hold off;
print(['-f' num2str(14)],[imgSavePath num2str(14) '_' 'Japanese vs German Cars'],'-dpng');

% CLUSTERIZATION

[filteredData emissionData.foundOutliers] = RemoveOutliersFromCoEmissions(carEmissionsDataset, 0);
[filteredData emissionData.foundOutliers] = RemoveOutliersFromFuelConsumption(filteredData, 0);
carEmissionsDatasetMatrix = filteredData{:, [10, 12:19]};
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 2);
filteredDataClusters = [table(idx) filteredData];
figure(15);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,2),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,2),'b.','MarkerSize',8)
plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3)
title('General Cluster with engine size');
legend('Cluster 1','Cluster 2','Centroids',...
'Location','NW')
hold off
print(['-f' num2str(15)],[imgSavePath num2str(15) '_' 'General Cluster with engine size'],'-dpng');

carEmissionsDatasetMatrix = carEmissionsDataset{:, [12:19]};
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 2);
filteredDataClusters_f16 = [table(idx) filteredData];
figure(16);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,2),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,2),'b.','MarkerSize',8)
plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3)
title('General Cluster WITHOUT engine size');
legend('Cluster 1','Cluster 2','Centroids',...
'Location','NW')
hold off
print(['-f' num2str(16)],[imgSavePath num2str(16) '_' 'General Cluster WITHOUT engine size'],'-dpng');


carEmissionsDatasetMatrix = normalize(carEmissionsDataset{:, [10, 14, 21]}, 'range',[0,1]);
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 2);
filteredDataClusters_f17 = [table(idx) filteredData];
figure(17);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,2),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,2),'b.','MarkerSize',8)
% plot(carEmissionsDatasetMatrix(idx==3,1),carEmissionsDatasetMatrix(idx==3,2),'g.','MarkerSize',8)
% plot(carEmissionsDatasetMatrix(idx==4,1),carEmissionsDatasetMatrix(idx==4,2),'y.','MarkerSize',8)
title("Engine Capacity vs Fuel Consumption")
plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3)
xlabel("Engine Capacity [cm^3]")
ylabel("Fuel Consumption")
% legend('Cluster 1','Cluster 2', 'Cluster 3', 'Cluster 4','Centroids',...
legend('Cluster 1','Cluster 2', 'Centroids',...
'Location','NW')
hold off
print(['-f' num2str(17)],[imgSavePath num2str(17) '_' 'Engine Capacity vs Fuel Consumption'],'-dpng');


% CLASIFICATION 3-dim 2-cl

conf_mtx = testClassification(carEmissionsDatasetMatrix, idx, C, 10000, 10);
figure(20);
heatmap(100 * conf_mtx ./ sum(conf_mtx, 'all'));
xlabel('Actual cluster');
ylabel('Classified cluster');
title('CM 3-dim classification - 2 clusters');
colorbar off;
print(['-f' num2str(20)],[imgSavePath num2str(20) '_' 'CM_classification_3-dim_2-cl'],'-dpng');

carEmissionsDatasetMatrix = normalize(carEmissionsDataset{:, [10, 14, 21]});
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 4);
filteredDataClusters_f18f19 = [table(idx) filteredData];
figure(18);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,3),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,3),'b.','MarkerSize',8)
plot(carEmissionsDatasetMatrix(idx==3,1),carEmissionsDatasetMatrix(idx==3,3),'g.','MarkerSize',8)
plot(carEmissionsDatasetMatrix(idx==4,1),carEmissionsDatasetMatrix(idx==4,3),'y.','MarkerSize',8)
title("Engine Capacity vs CO Emissions")
plot(C(:,1),C(:,3),'kx', 'MarkerSize',15,'LineWidth',3)
xlabel("Engine Capacity [cm^3]")
ylabel("CO Emissions")
legend('Cluster 1','Cluster 2', 'Cluster 3', 'Cluster 4','Centroids',...
'Location','NW')
hold off
print(['-f' num2str(18)],[imgSavePath num2str(18) '_' 'Engine Capacity vs CO Emissions'],'-dpng');

% carEmissionsDatasetMatrix = normalize(carEmissionsDataset{:, [10, 14, 21]});
% [idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 3);
figure(21);
plot(carEmissionsDatasetMatrix(idx==1,2),carEmissionsDatasetMatrix(idx==1,3),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,2),carEmissionsDatasetMatrix(idx==2,3),'b.','MarkerSize',8)
plot(carEmissionsDatasetMatrix(idx==3,2),carEmissionsDatasetMatrix(idx==3,3),'g.','MarkerSize',8)
plot(carEmissionsDatasetMatrix(idx==4,2),carEmissionsDatasetMatrix(idx==4,3),'y.','MarkerSize',8)
title("Fuel Consumption vs CO Emissions")
plot(C(:,2),C(:,3),'kx', 'MarkerSize',15,'LineWidth',3)
xlabel("Fuel Consumption")
ylabel("CO Emissions")
legend('Cluster 1','Cluster 2', 'Cluster 3', 'Cluster 4','Centroids',...
'Location','NW')
hold off
print(['-f' num2str(19)],[imgSavePath num2str(19) '_' 'Fuel Consumption vs CO Emissions'],'-dpng');


% CLASIFICATION 3-dim 4-cl

conf_mtx = testClassification(carEmissionsDatasetMatrix, idx, C, 10000, 10);
figure(21);
heatmap(100 * conf_mtx ./ sum(conf_mtx, 'all'));
xlabel('Actual cluster');
ylabel('Classified cluster');
title('CM 3-dim classification - 4 clusters');
colorbar off;
print(['-f' num2str(21)],[imgSavePath num2str(21) '_' 'CM_classification_3-dim_4-cl'],'-dpng');


% Check Silhouette eval value for oprimal num of Clusters
eva = evalclusters(carEmissionsDatasetMatrix(:,:),'kmeans', 'Silhouette', 'KList',[1:10]);
display(['Optimal num of Clusters calc by Silhouette eval: ' num2str(eva.OptimalK)]);

function clfall
    FigList = findall(groot, 'Type', 'figure');
    for iFig = 1:numel(FigList)
        try
        clf(FigList(iFig));
        catch
        % Nothing to do
        end
    end
end