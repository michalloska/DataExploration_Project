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
title('Petrol automatic cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
figure
histogram(allDieselAutomaticCars.engine_capacity, [50:100:5000]);
title('Diesel automatic cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
figure
histogram(allPetrolManualCars.engine_capacity, [50:100:5000]);
title('Petrol manual cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
figure
histogram(allDieselManualCars.engine_capacity, [50:100:5000]);
title('Diesel manual cars');
xlabel('Engine Capcity [cm^3]');
ylabel('Amount of Cars');
