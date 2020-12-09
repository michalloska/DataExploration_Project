import pandas as pd
import numpy as np
from scipy.cluster.hierarchy import dendrogram

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

def plot_dendrogram(model, **kwargs):
    # Create linkage matrix and then plot the dendrogram

    # create the counts of samples under each node
    counts = np.zeros(model.children_.shape[0])
    n_samples = len(model.labels_)
    for i, merge in enumerate(model.children_):
        current_count = 0
        for child_idx in merge:
            if child_idx < n_samples:
                current_count += 1  # leaf node
            else:
                current_count += counts[child_idx - n_samples]
        counts[i] = current_count

    linkage_matrix = np.column_stack([model.children_, model.distances_,
                                      counts]).astype(float)

    # Plot the corresponding dendrogram
    dendrogram(linkage_matrix, **kwargs)

def normalize(df):
    result = df.copy()
    for feature_name in df.columns:
        max_value = df[feature_name].max()
        min_value = df[feature_name].min()
        result[feature_name] = (df[feature_name] - min_value) / (max_value - min_value)
    return result

if __name__ == '__main__':
    pass