function [filteredDataset1, filteredDataset2] = removeOddCountries(dataset1, dataset2)
    dataset1Length = size(dataset1,1);
    dataset2Length = size(dataset2,1);
    
    filteredDataset1 = dataset1;
    filteredDataset2 = dataset2;
    
    
    
    for i = 2:dataset1Length-2
        found = false;
        for j = 2:dataset2Length-2
            tempI = dataset1{i,1};
            tempJ = dataset2{j,1};
            if strcmp(tempI, tempJ)
                found = true;
                break;
            end
            found = false;
        end
        if found == false
            filteredDataset1(i,:) = [];
        end
    end
end
