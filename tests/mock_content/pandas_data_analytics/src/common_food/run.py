import src.utils as u
import re
import toml
from pandas_data_analytics import *
import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import functools as ft
from py_linq import Enumerable

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))
u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['data']

df: pd.DataFrame = pd.read_csv(csv_loc)
df.columns = df.columns.str.lower()
nums = ['protein', 'carbs', 'fat', 'sat.fat', 'grams', 'calories', 'fiber']
for c in nums:
  df[c] = df[c]\
    .str.replace('[a-zA-Z,\']', '', regex=True)
df = df.replace(r'^\s*$', np.nan, regex=True)
# df = df.convert_dtypes()

for c in nums:
  df[c] = df[c].astype('float')

df['cal_per_gram'] = df.calories / df.grams

# set pandas dataframe options
pd.set_option('display.max_rows', df.shape[0] + 1)
pd.set_option('display.max_columns', df.shape[1] + 1)
pd.set_option('display.width', 1000)

pdf = df
ps = Enumerable([
  # lambda: pdf.sample(5),
  # lambda: pdf.columns,
  # lambda: pdf.dtypes,
  # lambda: pdf[['food', 'cal_per_gram']].sort_values('cal_per_gram'),
  lambda: pdf.category.value_counts(),
  lambda: pdf.groupby('category').apply(lambda x:\
                                        x.nlargest(n=5, columns='cal_per_gram'))[['food', 'cal_per_gram']]
  # lambda: df[df['food'].str.contains("milk", flags=re.I)][['food',
  # 'category']]['category'].value_counts() #.groupby('category').count(),
])
# g = df.groupby(['id']).apply(lambda x: x.nlargest(topk,['value'])).reset_index(drop=True)

u.foreach(lambda f: print(f()), ps)
# df.to_csv(config['file_locations']['clean_data'])

# Apply the default theme
sns.set_theme()

# aplot = sns.boxplot(y='category', x='cal_per_gram', data=df)
# General plot stuff
# aplot.set_xticklabels(aplot.get_xticklabels(), rotation=25)
# plt.show()
