function matrixNoCountryColumn = removeCountryColumn(dataset1)
    matrixNoCountryColumn = dataset1{:,2:size(dataset1,2)};
end