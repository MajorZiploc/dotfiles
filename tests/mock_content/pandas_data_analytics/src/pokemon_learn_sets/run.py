from py_linq import Enumerable
import json
import numpy as np
import os
import pandas as pd
import src.utils as u
import re
import seaborn as sns
import toml
import math


def main():
  def view_data(pdf):
    # pdf.style.set_properties(**{'width': '300px'})
    field = 'moves_learnt_by_tr' + '_'
    pdf = pdf.filter(regex=f'{field}|name', axis=1)
    # pdf.columns[pdf.columns.str.contains(f'({field}.*|name|generation)', flags=re.I,regex=True)]
    total_rows = len(pdf.index.value_counts())
    unique_rows = len(pdf.drop_duplicates().index.value_counts())
    dup_rows = len(pdf[pdf.duplicated()].index.value_counts())
    percent_duped = (dup_rows / total_rows) * 100
    ps = Enumerable([
      # lambda: pdf.isna().mean().sort_values(ascending=False),
      lambda: pdf.columns,
      lambda: total_rows,
      lambda: unique_rows,
      lambda: dup_rows,
      lambda: percent_duped,
      lambda: pdf.dropna().sample(7),
      # lambda: pdf.sort_values(['name', 'generation', 'moves_learnt_by_level_up_lvl']).drop([], axis=1).sample(5),
      # lambda: pdf.sort_values(['name', 'generation', 'moves_learnt_by_level_up_lvl']).sample(5),
      # lambda: pdf[pdf.duplicated()].sort_values(['name', 'generation'])
    ])
    u.foreach(lambda f: print(f()), ps)

  def implode_move_sets(movesdf, moves):
    # describes what to do with each move set
    agg_dict = {}
    for m in moves:
      agg_dict[f'{m}_json'] = lambda x: x.tolist()
    # 'Implodes' data frame move sets into lists
    csv_move_df = movesdf\
        .groupby(['name', 'generation'])\
        .agg(agg_dict, regex=True)\
        .reset_index()

    def move_list_filter(j):
      d = json.loads(j)
      return d['move'] is not None

    # Ex: If on Golem, we will drop Alonan form Golem moves
    def drop_alternate_form_moves(l):
      current_highest_number = -1
      move_list = []
      for d in l:
        j = json.loads(d)
        if (j['lvl'].isnumeric()):
          num = int(j['lvl'])
          if (num < current_highest_number):
            break
          else:
            current_highest_number = num
            move_list.append(j)
      return move_list

    for field in Enumerable(moves).select(lambda m: m + '_json'):
      csv_move_df[field] = csv_move_df[field]\
        .apply(lambda l: Enumerable(l)
               .where(move_list_filter))\
        .apply(drop_alternate_form_moves)
    # dups are due to alonan forms/ alter form tabs for move sets
    # try to filter then out based on if the number in the move set entry restarts
    # FOR EACH GENERATION
    # if 1..23..88 then 2..22..88
      # then drop the entries from 2 onward since these are alonan form move sets
    return csv_move_df

  this_dir = os.path.dirname(os.path.realpath(__file__))
  config = toml.load(os.path.join(this_dir, 'config.toml'))
  u.set_full_paths(config, this_dir)
  csv_loc = config['file_locations']['data']
  df: pd.DataFrame = pd.read_csv(csv_loc)
  df = df.drop(
    ['web-scraper-order',
     'web-scraper-start-url',
     'name_link-href',
     'generation-href'
     ], axis=1)
  pd.set_option('display.max_rows', df.shape[0] + 1)
  pd.set_option('display.max_columns', 175)

  # name field is unique per pokemon
  # movesdf: pd.DataFrame = df[['name', 'moves_learnt_by_level_up', 'generation']].dropna()
  movesdf: pd.DataFrame = df.drop(['name_link'], axis=1)
  types = [
      'ground',
      'electric',
      'bug',
      'ghost',
      'normal',
      'psychic',
      'fire',
      'fairy',
      'dark',
      'grass',
      'fighting',
      'water',
      'ice',
      'dragon',
      'poison',
      'rock',
      'flying',
      'steel']

  # def get_thing(phrase, s):
  #   m = re.search(phrase,s)
  #   return m.group(1) if m is not None\
  #     else np.nan
  # def parse_moves_lvl_up(s):
  #   lvl = get_thing('^(\d+)', s)
  #   return lvl
  # movesdf['moves_learnt_by_level_up_lvl'] = movesdf.moves_learnt_by_level_up.apply(parse_moves_lvl_up)

  def parse_moves(df: pd.DataFrame, field: str):
    ldf = pd.DataFrame()
    ldf[f'{field}_lvl'] = df[field]\
        .str.replace(r'(^\d+)(.*)', r'\1', regex=True)
    ldf[f'{field}_move'] = df[field]\
        .str.replace('(^.*?)(\\D+(?:' + '|'.join(types) + '))(.*)', r'\2', regex=True, flags=re.I)\
        .str.replace('(.*?)(' + '|'.join(types) + ')' + '$', r'\1', regex=True, flags=re.I)
    ldf[f'{field}_type'] = df[field]\
        .str.replace('(^.*?)(\\D+(?:' + '|'.join(types) + '))(.*)', r'\2', regex=True, flags=re.I)\
        .str.replace('(.*?)(' + '|'.join(types) + ')' + '$', r'\2', regex=True, flags=re.I)
    ldf[f'{field}_power'] = df[field]\
        .str.strip()\
        .str.replace('(^\\d+)(\\D+(?:' + '|'.join(types) + '))(.*)', r'\3', regex=True, flags=re.I)\
        .str.replace(r'(.*?)(\d{,4}|—|∞)\s{,4}(\d{,4}|—|∞)$', r'\2', regex=True, flags=re.I)\
        .str.replace(r'∞', 'inf', regex=True)\
        .str.replace(r'—', '', regex=True)
    ldf[f'{field}_acc'] = df[field]\
        .str.strip()\
        .str.replace('(^\\d+)(\\D+(?:' + '|'.join(types) + '))(.*)', r'\3', regex=True, flags=re.I)\
        .str.replace(r'(.*?)(\d{,4}|—|∞)\s{,4}(\d{,4}|—|∞)$', r'\3', regex=True, flags=re.I)\
        .str.replace(r'∞', 'inf', regex=True)\
        .str.replace(r'—', '', regex=True)
    return ldf

  # print(df.columns)

  moves = [
    'moves_learnt_by_level_up',
    'moves_learnt_by_tm',
    'moves_learnt_by_tr',
    'moves_learnt_by_move_tutor',
    'moves_learnt_by_egg',
    'moves_learnt_by_hm',
    'moves_learnt_by_transfer',
    'moves_learnt_by_evolution'
  ]
  for f in moves:
    ldf = parse_moves(movesdf, f)
    # to have move data in columns
    # movesdf = pd.concat([movesdf,ldf],axis=1)
    # to have move data in json format in 1 column
    ldf.columns = ldf.columns\
        .str.replace(f, '', regex=True)\
        .str.replace('_', '', regex=True)
    movesdf[f'{f}_json'] = ldf.to_json(orient='records', lines=True).splitlines()
    # print(f)
    # print(movesdf[f'{f}_json'].tolist()[0:10])

  csv_move_df = implode_move_sets(movesdf, moves)
  # print(type(csv_move_df))
  print(csv_move_df.columns)
  print(len(csv_move_df))
  # print(csv_move_df.sample(6))
  # csv_move_df.to_csv(config['file_locations']['cleaned_data'], index=False)
  general_df = df.drop(
    [
      'moves_learnt_by_level_up', 'moves_learnt_by_tm',
      'moves_learnt_by_tr', 'moves_learnt_by_move_tutor',
      'moves_learnt_by_egg', 'moves_learnt_by_hm',
      'moves_learnt_by_transfer', 'moves_learnt_by_evolution'
    ],
    axis=1
  ).drop_duplicates()
  print(len(df))
  print(len(general_df))
  print(general_df.columns)


main()
