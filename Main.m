clear
clc

datasetsLocation = 'datasets';
colon = '/'; % OS compatibility
prefix = [datasetsLocation colon];

coalConsumptionData = LoadDataFromCsv([prefix 'coal_consumption_total.csv']);
co2emissionsData    = LoadDataFromCsv([prefix 'co2_emissions_tonnes_per_person.csv']);
hivData             = LoadDataFromCsv([prefix 'people_living_with_hiv_number_all_ages.csv']);
populationData      = LoadDataFromCsv([prefix 'population_total.csv']);

[coalConsumptionDataUnified hivDataUnified] = UnifyDatasets(coalConsumptionData, hivData, true);

% corellation = CalculateCorrelation(coalConsumptionDataUnified, hivDataUnified);