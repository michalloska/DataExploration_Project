function resizedDataset = removeDatesOutOfScope(dataset1, startingYear, endYear)
    secondColumn = 2;

    while dataset1{1,secondColumn} < startingYear
        dataset1(:,secondColumn) = [];
    end

    j = size(dataset1, 2);
    while dataset1{1,j} > endYear
        dataset1(:,j) = [];
        j = j - 1;
    end

    resizedDataset = dataset1;
end