from pandas_data_analytics import *
from py_linq import Enumerable
import matplotlib.pyplot as plt
import os
import pandas as pd
import src.utils as u
import re
import seaborn as sns
import toml

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))
u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['data']

df: pd.DataFrame = pd.read_csv(csv_loc)
df.drop('should_delete', axis=1, inplace=True)
df = df.convert_dtypes()
df.date = pd.to_datetime(df.date)

pd.set_option('display.max_rows', df.shape[0] + 1)
pd.set_option('display.max_columns', 175)

date_bins = pd.interval_range(start=pd.Timestamp('2020-07-01'),
                              periods=10, freq='MS')
df['date_range'] = pd.cut(df.date, date_bins)
df['muscle_weight'] = df.morning_weight * df.muscle_mass_percentage / 100
df['body_fat_weight'] = df.morning_weight * df.body_fat_percentage / 100
df['other_weight'] = df.morning_weight - df.muscle_weight - df.body_fat_weight
weights = Enumerable(
    df.drop(
        'morning_weight',
        axis=1).columns).where(
            lambda c: re.match(
                '.*_weight',
                c,
                re.I)).to_list()
# exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp',c,re.I)).to_list()
mdf: pd.DataFrame = pd.melt(df, id_vars=['date'], value_vars=weights, value_name='lbs', var_name='weight_category')
mdf.dropna(inplace=True)
mdf['date_range'] = pd.cut(mdf.date, date_bins)
mdf = mdf.convert_dtypes()
mdf.weight_category = mdf.weight_category.astype('category')
mdf.lbs = mdf.lbs.astype('Int64')

recentdf = df  # [(df['date']>pd.Timestamp(2020,11,24)) & (df['date']<pd.Timestamp(2021,1,23))]

pd.set_option('display.max_rows', mdf.shape[0] + 1)
# pd.set_option('display.max_columns', mdf.shape[1]+1)

# diffdf = recentdf.iloc[-1] - recentdf.iloc[0]
pdf: pd.DataFrame = mdf
ps = Enumerable([
  lambda: pdf.columns,
  lambda: pdf.dtypes,
  # lambda: pdf.lbs.head(5),
  # lambda: date_bins,
  # lambda: pdf.dtypes,
  # lambda: pdf.describe(include='all', datetime_is_numeric=True),
  # lambda: pdf.sample(5),
  # lambda: monthly_summaries_df,
  # lambda: pdf.sort_values('calories')
])
u.foreach(lambda f: print(f()), ps)

# write out monthly summaries of stats
# monthly_summaries_df: pd.DataFrame = pdf.groupby(by='date_range').agg(['mean', 'std', 'min', 'max']).unstack().reset_index()
# monthly_summaries_df.columns = monthly_summaries_df.columns.astype(str)
# monthly_summaries_df.rename(columns={'level_0':'metric', 'level_1':'stat', '0': 'num'}, inplace=True)
# monthly_summaries_df.to_csv(config['file_locations']['monthly_summaries'], index=False)

# Apply the default theme
sns.set_theme()

# aplot = sns.barplot(x='date_range', y='lbs', hue='weight_category', data=mdf)
aplot = sns.boxplot(y='date_range', x='calories', data=df)

# aplot = sns.lineplot(x='date', y='calories', data=df)
# aplot = sns.lineplot(x='date', y='muscle_weight', data=df)
# aplot = sns.lineplot(x='date', y='body_fat_weight', data=df)
# aplot = sns.lineplot(x='date', y='other_weight', data=df)

# General plot stuff
plt.show()
aplot = sns.boxplot(y='date_range', x='morning_weight', data=df)
plt.show()
