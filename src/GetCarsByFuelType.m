function matchingCars = GetCarsByFuelType(fuelType, dataset)
    matchingCars = dataset(dataset.fuel_type == string(fuelType), :);
end