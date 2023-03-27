import pandas as pd
import json

# read the json and put it into a dataframe
path = 'C:/Users/a/PycharmProjects/dev/assignment/data/orders.jsonl'
df = pd.read_json(path, lines=True)

# using json_normalize to flatten the data
json_structure = json.loads(df.to_json(orient="records"))
df_flat = pd.json_normalize(json_structure)

# nulls, datatypes and column names
df_flat['IsBusinessOrder'].fillna(0, inplace=True)
df_flat['IsBusinessOrder'] = df_flat['IsBusinessOrder'].astype(int).astype(bool)
df_flat = df_flat.drop(['ShippingAddress', 'OrderTotal', 'ShippingAddress.County'], axis=1)
df_flat['ShippingAddress.City'] = df_flat['ShippingAddress.City'].str.lower()
df_flat['ShippingAddress.StateOrRegion'] = df_flat['ShippingAddress.StateOrRegion'].str.lower()
df_renamed = df_flat.rename(columns={'ShippingAddress.StateOrRegion': 'StateOrRegion',
                                     'ShippingAddress.PostalCode': 'PostalCode',
                                     'ShippingAddress.City': 'City',
                                     'ShippingAddress.CountryCode': 'CountryCode',
                                     'OrderTotal.CurrencyCode': 'Currency',
                                     'OrderTotal.Amount': 'Amount'
                                     })

# removing duplicates
df_final = df_renamed.drop_duplicates()

# new columns added
df_final['Year'] = pd.to_datetime(df_final['LastUpdateDate']).dt.strftime('%Y')
df_final['Year-Month'] = df_final['Year'] + pd.to_datetime(df_final['LastUpdateDate']).dt.strftime('%m')
df_final['year-quarter'] = pd.PeriodIndex(df_final['LastUpdateDate'], freq='Q')
df_final['week'] = pd.to_datetime(df_final['LastUpdateDate']).dt.strftime('%Y') + 'W' + pd.to_datetime(
    df_final['LastUpdateDate']).dt.strftime('%W')

print(df_final.to_string())
