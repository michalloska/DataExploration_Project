datasetsLocation = 'datasets';
colon = '/'; % OS compatibility

coalConsumptionData = LoadDataFromCsv([datasetsLocation colon 'coal_consumption_total.csv']);
co2emissionsData    = LoadDataFromCsv([datasetsLocation colon 'co2_emissions_tonnes_per_person.csv']);
hivData             = LoadDataFromCsv([datasetsLocation colon 'people_living_with_hiv_number_all_ages.csv']);
populationData      = LoadDataFromCsv([datasetsLocation colon 'population_total.csv']);

corellation = CalculateCorrelation(coalConsumptionData, hivData);