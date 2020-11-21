% Adrian Wysocki
% Michal Loska

clc
clear

carEmissionsDatasetPath = '../data/carEmissions.csv';
carEmissionsDataset = readtable(carEmissionsDatasetPath);

allAutomaticCars = removeTransiossionType(carEmissionsDataset, 'Manual');
allManualCars = removeTransiossionType(carEmissionsDataset, 'Automatic');

allPetrolAutomaticCars = GetCarsByFuelType('Petrol', allAutomaticCars);
allDieselAutomaticCars = GetCarsByFuelType('Diesel', allAutomaticCars);
allPetrolManualCars = GetCarsByFuelType('Petrol', allManualCars);
allDieselManualCars = GetCarsByFuelType('Diesel', allManualCars);
