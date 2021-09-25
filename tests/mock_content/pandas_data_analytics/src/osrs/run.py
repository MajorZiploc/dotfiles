import src.utils as u
import toml
import re
import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from py_linq import Enumerable

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))

u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['training_data']

df = pd.read_csv(csv_loc)

# have to migrate on columns matching *_exp to skill and skill_exp columns
# 1 row becomes many rows
# sdf = df.stack().to_frame().T
# print(sdf)
df.drop(['web-scraper-order', 'web-scraper-start-url', 'char_link-href'], inplace=True, axis=1)
df.rename(columns={'char_link': 'character'}, inplace=True)

# u.general_df_stats(df)

# get columns that have exp in the name
exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp', c, re.I)).to_list()
# exps = df.filter(regex=(".*_exp"))
print(exps)


# def r(s):
#     return re.sub('\D+', '', flags=re.I, string=s)


# def remove_exp(s):
#     return re.sub('(.*)_exp$', '\\1', flags=re.I, string=s)

def skill_binner(skill):
  return 'combat' if re.search(
      '(attack|str|hp|def|rang|mage|pray)', skill)\
      else 'gathering' if re.search(
      '(wc|fish|hunt|mining|farm)', skill)\
      else 'artisan(production)' if re.search(
      '(fm|cook|smith|craft|rc|herb|fletch|con)', skill)\
      else 'support'


mdf: pd.DataFrame = pd.melt(df, id_vars=['character'], value_vars=exps, value_name='exp', var_name='skill')
# mdf.rename(columns={'value': 'exp', 'variable': 'skill'}, inplace=True)
mdf['skill_bin'] = mdf['skill'].apply(skill_binner)
# mdf['exp'] = mdf['exp'].apply(r)
mdf['exp'] = mdf['exp'].str.replace('\\D+', '', regex=True, flags=re.I)
# mdf['skill'] = mdf['skill'].apply(remove_exp)
mdf['skill'] = mdf['skill'].str.replace('(.*)_exp$', '\\1', regex=True, flags=re.I)
mdf['exp'] = mdf['exp'].astype('int')
mdf = mdf.sort_values('skill_bin')

# bplot = sns.barplot(x='character', y='exp', hue='skill_bin',
#                     data=mdf)  # , palette=sns.color_palette('hls', 30))
# bplot.set_xticklabels(bplot.get_xticklabels(), rotation=10)

# bplot = sns.barplot(x='skill', y='exp',
#                     data=mdf)  # , palette=sns.color_palette('hls', 30))
# bplot.set_xticklabels(bplot.get_xticklabels(), rotation=10)

# bplot = sns.barplot(x='skill', y='exp',data=mdf)
# bplot.set_xticklabels(bplot.get_xticklabels(), rotation=25)
# plt.show()
# OR
# bplot.set_xticklabels(rotation=25)

# NOT WORKING!
# g = sns.FacetGrid(mdf, col="skill_bin")
# g.map(sns.barplot, 'skill', 'exp')
# g.add_legend()
# for ax in g.axes.flat:
#     for label in ax.get_xticklabels():
#         label.set_rotation(30)

# global settings of sns style
# sns.set_style

# good plotting for distribution of catagories
# sns.catplot(y='skill', x='exp', data=mdf, hue='skill_bin')
# sns.violinplot(x='skill', y='exp', data=mdf)
# sns.histplot(x='skill', y='exp', data=mdf)
# sns.boxplot(y='skill', x='exp', data=mdf)
# sns.jointplot is good for numeric x,y scatter plot for checking bin relationships
# plt.show()
print(mdf.head(100))
exp_df: pd.DataFrame = df.loc[:, df.columns.isin(Enumerable(
  df.columns).where(lambda c: re.match('.*exp', c)).to_list())]
# def keep_digits(e):
#     r = re.sub('\D', '', e)
#     return r

# exp_df = exp_df.applymap(keep_digits).astype(int)
exp_df = exp_df.replace('\\D', '', regex=True).astype(int)
mean_exp = exp_df.mean().astype(int)
# print(mean_exp)
# the number of skills within each skill_bin: Length of a group: groupby length
print(mdf.groupby('skill_bin').apply(lambda x: len(x.skill.unique())))
# the number of rows for each skill
print(mdf.value_counts('skill'))
# sns.heatmap(exp_df.corr())

# plt.show()
