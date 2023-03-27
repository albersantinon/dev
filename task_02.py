import pandas as pd
import json

# read the json and put it into a dataframe
path = 'C:/Users/a/PycharmProjects/dev/assignment/data/orders.jsonl'
df = pd.read_json(path, lines=True)

# using json_normalize method to flatten the data
json_structure = json.loads(df.to_json(orient="records"))
df_flat = pd.json_normalize(json_structure)


# function to make column values all lowercase
def lower_case(column_name, data_frame):
    data_frame[column_name] = data_frame[column_name].str.lower()
    return data_frame


# function to rename a column
def rename_columns(column_dict, data_frame):
    data_frame = data_frame.rename(columns=column_dict)
    return data_frame


# function to drop columns
def drop_columns(column_list, data_frame):
    data_frame = data_frame.drop(column_list, axis=1, inplace=True)
    return data_frame


# dictionary to save the columns mapping to be renamed
renamed_columns = {'ShippingAddress.StateOrRegion': 'StateOrRegion',
                   'ShippingAddress.PostalCode': 'PostalCode',
                   'ShippingAddress.City': 'City',
                   'ShippingAddress.CountryCode': 'CountryCode',
                   'OrderTotal.CurrencyCode': 'Currency',
                   'OrderTotal.Amount': 'Amount'
                   }


def main():
    try:
        # transformations: nulls, datatypes and columns management
        df_flat['IsBusinessOrder'].fillna(0, inplace=True)
        df_flat['IsBusinessOrder'] = df_flat['IsBusinessOrder'].astype(int).astype(bool)
        drop_columns(['ShippingAddress', 'OrderTotal', 'ShippingAddress.County'], df_flat)
        lower_case('ShippingAddress.City', df_flat)
        lower_case('ShippingAddress.StateOrRegion', df_flat)
        df_renamed = rename_columns(renamed_columns, df_flat)

        # removing duplicates
        df_final = df_renamed.drop_duplicates()

        # new calculated columns
        df_final['Year'] = pd.to_datetime(df_final['LastUpdateDate']).dt.strftime('%Y')
        df_final['Year-Month'] = df_final['Year'] + pd.to_datetime(df_final['LastUpdateDate']).dt.strftime('%m')
        df_final['Year-Quarter'] = pd.PeriodIndex(df_final['LastUpdateDate'], freq='Q')
        df_final['Week'] = pd.to_datetime(df_final['LastUpdateDate']).dt.strftime('%Y') + 'W' + pd.to_datetime(
            df_final['LastUpdateDate']).dt.strftime('%W')
        df_final['Weekday'] = pd.to_datetime(df_final['LastUpdateDate']).dt.weekday + 1

        # exporting the dataframe to a csv
        df_final.to_csv('file.csv', index=False)

    finally:
        print(df_final.to_string())


main()
