% 2020
% Adrian Wysocki
% Michal Loska

clc
clear

carEmissionsDatasetPath = '../data/carEmissions.csv';
carEmissionsDataset = readtable(carEmissionsDatasetPath);

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


averageEmissionsPetrolAutomatic = GetAverageEmissionsForEngineSizes(allPetrolAutomaticCars, engineCapacityRange);
averageEmissionsDieselAutomatic = GetAverageEmissionsForEngineSizes(allDieselAutomaticCars, engineCapacityRange);
averageEmissionsPetrolManual    = GetAverageEmissionsForEngineSizes(allPetrolManualCars, engineCapacityRange);
averageEmissionsDieselManual    = GetAverageEmissionsForEngineSizes(allDieselManualCars, engineCapacityRange);

allCars = [averageEmissionsPetrolAutomatic(:,1)';...
           averageEmissionsDieselAutomatic(:,1)';...
           averageEmissionsPetrolManual(:,1)';...
           averageEmissionsDieselManual(:,1)'];

figure(6);
plot(averageEmissionsDieselAutomatic(:,2)', allCars);
title('Average emissions for engine capacities');
ylim([0 1000])
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Petrol Automatic",...
        "Diesel Automatic",...
        "Petrol Manual",...
        "Diesel Manual"])

