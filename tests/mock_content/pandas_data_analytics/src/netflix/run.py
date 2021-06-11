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
# df.dropna(how='any', inplace=True)
df = df.convert_dtypes()
df.type = df.type.astype('category')
df.date_added = pd.to_datetime(df.date_added)
df['year_added'] = df.date_added.dt.year.astype('Int64').astype('category')
df.release_year = df.release_year.astype('category')
df.rating = df.rating.astype('category')
# string nan values become <NA>, still a rep for nan
pd.set_option('display.max_rows', df.shape[0] + 1)


def drop_filler(g):
  l = ['Movies', 'TV Shows', 'TV', 'Shows', 'Series', 'Features']
  if(Enumerable(l).any(lambda e: g.lower() == e.lower())):
    return g
  return re.sub('|'.join(l), '', g, flags=re.I)


# creates bins for the durations, does not include season info
# only assigns indices where duration was minute based
df['duration_bin'] = pd.cut(df[~df.duration.str.contains('season', flags=re.I)]
                            .duration.str.split(' ', expand=True)[0].str.strip().astype('int')
                            .sort_values(), bins=np.linspace(0, 350, 8))


def genre_df_sup():
  genre_df: pd.DataFrame = df[
    ['date_added', 'release_year', 'rating', 'duration', 'year_added']
  ].assign(genre=df["listed_in"]
           .str.split(", ")).explode('genre')
  genre_df.genre = genre_df.genre.apply(drop_filler).str.strip()
  genre_df.genre = genre_df.genre.astype('category')
  return genre_df


def director_df_sup():
  director_df: pd.DataFrame = df[
    ['director', 'date_added', 'release_year', 'rating', 'duration', 'year_added']
  ].assign(director=df['director']
           .str.split(', ')).explode('director')
  director_df.director = director_df.director.astype('category')
  return director_df


def country_df_sup():
  country_df = df[
    ['country', 'director', 'date_added', 'release_year', 'rating', 'duration', 'year_added']
  ].assign(country=df.country.str.split(', '))\
    .explode('country')
  country_df.country = country_df.country.astype('category')
  return country_df


pdf = genre_df_sup()
field = 'country'
ps = Enumerable([
  # lambda: genre_df.genre.value_counts(normalize=True),
  # lambda: genre_df.groupby('year_added').genre.value_counts(normalize=True),
  # lambda: len(pdf[field].unique()),
  # lambda: pdf[~(pdf.year_added == pdf.release_year)].sample(5),
  lambda: pdf.isna().mean().sort_values(ascending=False),
  lambda: pdf.genre.value_counts(),
  # # len does not account for unique index
  # lambda: len(pdf),
  # lambda: len(df),
  # # len does account for unique index
  # lambda: len(df.index.value_counts()),
  # lambda: len(pdf.index.value_counts())
])
u.foreach(lambda f: print(f()), ps)

# good idea for analysis of top 10 cats
# ## Top 10 countries
# cols_country = list(df.country.value_counts().head(10).index.values)
# ## Top 10 genere
# cols_genere = list(df.listed_in.value_counts().head(10).index.values)
# mask1 = df['country'].isin(cols_country)
# mask2 = df['listed_in'].isin(cols_genere)
# plt.figure(figsize=(18,4))
# sns.countplot('country', hue='listed_in', data=df[mask1 & mask2])
# plt.title('Different type of content in Top 10 Countries')
# plt.show()

# Apply the default theme
sns.set_theme()

# show seasons in order with counts
# df['num_of_seasons'] = df[df.duration.str.contains('Season', flags=re.I)].duration.str.split(' ', expand=True)[0].astype(int)
# sdf = df[df.duration.str.contains('Season', flags=re.I)].sort_values(by='num_of_seasons')
# aplot = sns.countplot(data=sdf, x='duration')

# sns.countplot(x='year_added', data=df, hue='type')
# aplot = sns.countplot(x='duration_bin', data=df, hue='rating')

# General plot stuff
# aplot.set_xticklabels(aplot.get_xticklabels(), rotation=30)
# plt.show()
