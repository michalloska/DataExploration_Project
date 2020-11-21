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
plot(averageEmissionsPetrolAutomatic(:,2)', allCars);
title('Average emissions for engine capacities');
xlabel('Engine Capcity [cm^3]');
ylabel('co emissions');
legend(["Petrol Automatic",...
        "Diesel Automatic",...
        "Petrol Manual",...
        "Diesel Manual"])

