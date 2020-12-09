#!/usr/bin/env python3

import pandas as pd
import numpy as np

import helper
from matplotlib import pyplot as plt

from sklearn.cluster import AgglomerativeClustering


if __name__ == '__main__':
    data = pd.read_csv('../data/carEmissions.csv', sep=',')
    
    numeric_columns_headers = helper.get_numeric_columns_headers(data)
    string_columns_headers = helper.get_string_columns_headers(data)

    # removing unusual elements

    data = data.loc[data['co_emissions'] < 69000]
    data = data.loc[data['combined_metric'] < 30]
    

    # clusters for all data and reduce to 2 reduction to two dimensions
    all_numeric_data = data[numeric_columns_headers]


    # clusters for engine_capacity, co_emissions, combined_metric
    headers = ['engine_capacity', 'co_emissions', 'combined_metric']

    data_for_clusters = data[headers]

    data_for_clusters = helper.normalize(data_for_clusters)

    print('a')
    clustering = AgglomerativeClustering(distance_threshold=1, n_clusters=None)
    print('b')
    model = clustering.fit(data_for_clusters)
    print('c')
    helper.plot_dendrogram(model, truncate_mode='level', p=3)
    plt.xlabel("Number of points in node (or index of point if no parenthesis).")
    plt.show()
