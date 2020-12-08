#!/usr/bin/env python3

import pandas as pd
import numpy as np

import helper

if __name__ == '__main__':
    data = pd.read_csv('../data/carEmissions.csv', sep=',')
    
    numeric_columns_headers = helper.get_numeric_columns_headers(data)
    string_columns_headers = helper.get_string_columns_headers(data)

    # unusual elements detection
    helper.print_unusual_elements_in_column(data, 'engine_capacity', sigmas=6) # 6-sigma
    helper.print_unusual_elements_in_column(data, 'combined_metric', sigmas=6) # 6-sigma 
