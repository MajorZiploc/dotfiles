import os
import functools as ft


def l(df):
  return [df.head(), df.dtypes, df.shape, df.columns, df.index]


def p(df):
  foreach(print, l(df))


def foreach(action, iterable):
  for element in iterable:
    action(element)


def set_full_paths(config, directory):
  file_locations = config.get('file_locations', None)
  if(file_locations):
    for key, value in config['file_locations'].items():
      config['file_locations'][key] = os.path.join(directory, value)


def general_df_stats(df):
  def count_of_unique_members_per_column(df):
    s = ''
    for (columnName, columnData) in df.iteritems():
      s += 'Colunm Name: ' + columnName + '\n'
      s += 'Number of unique members: ' + \
          str((len(columnData.unique()))) + '\n'
    return s

  l = [
      '------------------------------- GENERAL DF STATS BEGIN -------------------------------',
      '=Top 5 entries=',
      df.head(),
      '=Types=',
      df.dtypes,
      '=Shape=',
      df.shape,
      '=Descriptions=',
      df.describe(include='all'),
      '=Null counts=',
      df.isna().sum(),
      '=Unique member counts=',
      count_of_unique_members_per_column(df),
      # '=DF info=',
      # df.info(),
      '------------------------------- GENERAL DF STATS END -------------------------------'
  ]

  def p(o):
    print('<<<>>>')
    print(o)
  foreach(p, l)


def create_cat_bins(bin_to_value_dictionary):
  def g(s):
    def f(acc, e):
      acc[e] = s
      return acc
    return f
  value_to_bin_dictionary = {}
  for key, value in bin_to_value_dictionary.items():
    value_to_bin_dictionary = ft.reduce(
        g(key), value, value_to_bin_dictionary)
  return value_to_bin_dictionary


# def top_n_per_group(df_groups):
#     for name, group in grouped:
#         print name
#         print group
