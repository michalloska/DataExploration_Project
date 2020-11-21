function table = GetTransmissionType(table, transmissionType)
    table = table(table.transmission_type == string(transmissionType), :);
end

