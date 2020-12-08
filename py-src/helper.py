import pandas as pd
import numpy as np

def get_string_columns_headers(data):
    string_columns = []
    for (col_name, col_data) in data.iteritems():
        if not pd.api.types.is_string_dtype(col_data):
            continue

        string_columns.append(col_name)

    return string_columns

def get_numeric_columns_headers(data):
    numeric_columns = []
    for (col_name, col_data) in data.iteritems():
        if pd.api.types.is_string_dtype(col_data):
            continue

        numeric_columns.append(col_name)

    return numeric_columns

def print_unusual_elements_in_column(data, column_name, sigmas=3):
    unusual_elements = find_unusual_elements_in_column(data, column_name, sigmas)
    headers_to_be_printed = ['year', 'manufacturer', 'model', 'description', column_name]
    print('---------- UNUSUAL ELEMENTS IN COLUMN {} ----------'.format(column_name))
    print(unusual_elements[headers_to_be_printed])

def find_unusual_elements_in_column(data, column_name, sigmas=3):
    column = data[column_name]
    mean_value = column.mean()
    std_deviation_value = column.std()
    unusual_elements = data.loc[abs(data[column_name] - mean_value) > sigmas * std_deviation_value]
    return unusual_elements

if __name__ == '__main__':
    pass