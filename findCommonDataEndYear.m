function commonEndYear = findCommonDataEndYear(dataset1, dataset2)
    dataset1Length = size(dataset1, 2);
    dataset2Length = size(dataset2, 2);
    commonEndYear = (min(dataset1{1,dataset1Length}, dataset2{1,dataset2Length}));
end