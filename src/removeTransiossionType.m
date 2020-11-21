function table = removeTransiossionType(table, toBeFound)
    
    toDelete = [];
    for i = 1:size(table, 1)
        if strcmp(string(table.transmission_type(i)), toBeFound)
            toDelete = [toDelete; i];
        end
    end
    table(toDelete, :) = [];
end

