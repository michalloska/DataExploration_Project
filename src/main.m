% Adrian Wysocki
% Michal Loska

clc
clear

carEmissionsDatasetPath = '../data/carEmissions.csv';
carEmissionsDataset = readtable(carEmissionsDatasetPath);

allAutomaticCars = GetTransmissionType(carEmissionsDataset, 'Automatic');
allManualCars = GetTransmissionType(carEmissionsDataset, 'Manual');

allPetrolAutomaticCars = GetCarsByFuelType('Petrol', allAutomaticCars);
allDieselAutomaticCars = GetCarsByFuelType('Diesel', allAutomaticCars);
allPetrolManualCars = GetCarsByFuelType('Petrol', allManualCars);
allDieselManualCars = GetCarsByFuelType('Diesel', allManualCars);


histogram(allPetrolAutomaticCars.engine_capacity, [50:100:5000]);
title('all petrol automatic cars');
xlabel('Engine Capcity [L]');
ylabel('Amount of Cars');
figure
histogram(allDieselAutomaticCars.engine_capacity, [50:100:5000]);
title('all diesel automatic cars');
xlabel('Engine Capcity [L]');
ylabel('Amount of Cars');
figure
histogram(allPetrolManualCars.engine_capacity, [50:100:5000]);
title('all petrol manual cars');
xlabel('Engine Capcity [L]');
ylabel('Amount of Cars');
figure
histogram(allDieselManualCars.engine_capacity, [50:100:5000]);
title('all diesel manual cars');
xlabel('Engine Capcity [L]');
ylabel('Amount of Cars');
