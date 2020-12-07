function selectedCars = GetDataByCarBrand(dataset, brands)
    car_brand_column_number = 21;
    selectedCars = dataset(ismember(dataset.manufacturer, brands), :);
end
