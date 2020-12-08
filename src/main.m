% 2020
% Adrian Wysocki
% Michal Loska

clc
clear
clf

carEmissionsDatasetPath = '../data/carEmissions.csv';
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
figure(2);
histogram(allDieselAutomaticCars.engine_capacity, engineCapacityRange);
title('Diesel automatic cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
figure(3);
histogram(allPetrolManualCars.engine_capacity, engineCapacityRange);
title('Petrol manual cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
figure(4);
histogram(allDieselManualCars.engine_capacity, engineCapacityRange);
title('Diesel manual cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');


PetrolAutomaticData = GetEmissionStatisticDataForEngineSize(allPetrolAutomaticCars, engineCapacityRange);
DieselAutomaticData = GetEmissionStatisticDataForEngineSize(allDieselAutomaticCars, engineCapacityRange);
PetrolManualData    = GetEmissionStatisticDataForEngineSize(allPetrolManualCars, engineCapacityRange);
DieselManualData    = GetEmissionStatisticDataForEngineSize(allDieselManualCars, engineCapacityRange);

allCars = [PetrolAutomaticData.avgCoEmissionPerEngSize(:,1)';...
           DieselAutomaticData.avgCoEmissionPerEngSize(:,1)';...
           PetrolManualData.avgCoEmissionPerEngSize(:,1)';...
           DieselManualData.avgCoEmissionPerEngSize(:,1)'];

figure(6);
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

figure(11);
plot(engineCapacityRange(1,1:length(engineCapacityRange)-1), allCarsNoOutliers);
title('Average emissions for engine capacities without Outliers');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Petrol Automatic",...
        "Diesel Automatic",...
        "Petrol Manual",...
        "Diesel Manual"])

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
[filteredData emissionData.foundOutliers] = RemoveOutliersFromCoEmissions(carEmissionsDataset, 0);
[filteredData emissionData.foundOutliers] = RemoveOutliersFromFuelConsumption(filteredData, 0);
carEmissionsDatasetMatrix = filteredData{:, [10, 12:19]};
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 2);
figure(15);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,2),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,2),'b.','MarkerSize',8)
plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Centroids',...
'Location','NW')
hold off

carEmissionsDatasetMatrix = carEmissionsDataset{:, [12:19]};
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 2);
figure(16);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,2),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,2),'b.','MarkerSize',8)
plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Centroids',...
'Location','NW')
hold off


carEmissionsDatasetMatrix = normalize(carEmissionsDataset{:, [10, 14, 21]}, 'range',[0,1]);
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 3);
figure(17);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,2),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,2),'b.','MarkerSize',8)
plot(carEmissionsDatasetMatrix(idx==3,1),carEmissionsDatasetMatrix(idx==3,2),'g.','MarkerSize',8)
title("Engine Size vs Fuel Consumption")
plot(C(:,1),C(:,2),'kx', 'MarkerSize',15,'LineWidth',3)
xlabel("Engine Size")
ylabel("Fuel Consumption")
legend('Cluster 1','Cluster 2', 'Cluster 3','Centroids',...
'Location','NW')
hold off

% carEmissionsDatasetMatrix = normalize(carEmissionsDataset{:, [10, 14, 21]});
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 3);
figure(18);
plot(carEmissionsDatasetMatrix(idx==1,1),carEmissionsDatasetMatrix(idx==1,3),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,1),carEmissionsDatasetMatrix(idx==2,3),'b.','MarkerSize',8)
plot(carEmissionsDatasetMatrix(idx==3,1),carEmissionsDatasetMatrix(idx==3,3),'g.','MarkerSize',8)
title("Engine Size vs CO Emissions")
plot(C(:,1),C(:,3),'kx', 'MarkerSize',15,'LineWidth',3)
xlabel("Engine Size")
ylabel("CO Emissions")
legend('Cluster 1','Cluster 2', 'Cluster 3','Centroids',...
'Location','NW')
hold off

% carEmissionsDatasetMatrix = normalize(carEmissionsDataset{:, [10, 14, 21]});
[idx, C] = kmeans(carEmissionsDatasetMatrix(:,:), 3);
figure(19);
plot(carEmissionsDatasetMatrix(idx==1,2),carEmissionsDatasetMatrix(idx==1,3),'r.','MarkerSize',8)
hold on
plot(carEmissionsDatasetMatrix(idx==2,2),carEmissionsDatasetMatrix(idx==2,3),'b.','MarkerSize',8)
plot(carEmissionsDatasetMatrix(idx==3,2),carEmissionsDatasetMatrix(idx==3,3),'g.','MarkerSize',8)
title("Fuel Consumption vs CO Emissions")
plot(C(:,2),C(:,3),'kx', 'MarkerSize',15,'LineWidth',3)
xlabel("Fuel Consumption")
ylabel("CO Emissions")
legend('Cluster 1','Cluster 2', 'Cluster 3','Centroids',...
'Location','NW')
hold off