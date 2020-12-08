#!/usr/bin/env python3

import pandas as pd
import numpy as np

import helper

if __name__ == '__main__':
    data = pd.read_csv('../data/carEmissions.csv', sep=',')
    
    numeric_columns_headers = helper.get_numeric_columns_headers(data)
    string_columns_headers = helper.get_string_columns_headers(data)
    
    # clusters for all data and reduce to 2 reduction to two dimensions
    all_numeric_data = data[numeric_columns_headers]
