#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check find_in_files '\bdf\.Columns' for proper listing of occurrences" {
  cd ./mock_content
  function f(){
    find_in_files '\bdf\.Columns' | sort -f
  }
  run f
  assert_success
expected="$(cat << EOF
./FslabDataAnalytics/FslabDataAnalytics/osrs/run.fs:30:        df.Columns.Keys
./FslabDataAnalytics/FslabDataAnalytics/osrs/run.fs:39:    printfn "%A" <| df.Columns.Keys
./pandas_data_analytics/src/body_comp/run.py:38:# exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp',c,re.I)).to_list()
./pandas_data_analytics/src/common_food/run.py:19:df.columns = df.columns.str.lower()
./pandas_data_analytics/src/osrs/run.py:29:exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp', c, re.I)).to_list()
./pandas_data_analytics/src/osrs/run.py:94:exp_df: pd.DataFrame = df.loc[:, df.columns.isin(Enumerable(
./pandas_data_analytics/src/osrs/run.py:95:  df.columns).where(lambda c: re.match('.*exp', c)).to_list())]
./pandas_data_analytics/src/pokemon_learn_sets/run.py:149:  # print(df.columns)
./pandas_data_analytics/src/utils/utils.py:6:  return [df.head(), df.dtypes, df.shape, df.columns, df.index]
EOF
)"
  assert_output "$expected"
  cd ..
}

@test "check find_in_files '\bdf\.Columns' '.*(osrs|common).*\.py' for proper listing of occurrences with a file pattern filter" {
  cd ./mock_content
  function f(){
    find_in_files '\bdf\.Columns' '.*(osrs|common).*\.py' | sort -f
  }
  run f
  assert_success
expected="$(cat << EOF
./pandas_data_analytics/src/common_food/run.py:19:df.columns = df.columns.str.lower()
./pandas_data_analytics/src/osrs/run.py:29:exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp', c, re.I)).to_list()
./pandas_data_analytics/src/osrs/run.py:94:exp_df: pd.DataFrame = df.loc[:, df.columns.isin(Enumerable(
./pandas_data_analytics/src/osrs/run.py:95:  df.columns).where(lambda c: re.match('.*exp', c)).to_list())]
EOF
)"
  assert_output "$expected"
  cd ..
}

@test "check find_in_files '\bfor\b' '.*\.py|.*README.*' '3' for proper listing of occurrences with a file pattern filter" {
  cd ./mock_content
  function f(){
    find_in_files '\bfor\b' '.*\.py|.*README.*' '3' | sort -f
  }
  run f
  assert_success
expected="$(cat << EOF
./FslabDataAnalytics/README.md:9:- ionide-fsharp extension for vscode
./pandas_data_analytics/README.md:11:Some of the data is personally scrapped using webscrapper.io. See my web_scraper_io_scripts repo for how to scrap this
./pandas_data_analytics/README.md:160:## Interactive (all required for launching an interactive shell)
./pandas_data_analytics/README.md:25:### To Create a new virtual environment for this project
./pandas_data_analytics/README.md:2:An area for exploratory data science; to clean, analyze, and visualize data. 
./pandas_data_analytics/README.md:50:setup.py with the follow line of code is required for references project files in other project files for import statements
./pandas_data_analytics/README.md:72:    <td>chunks pandas dataframes for scaling. async utils aswell</td>
./pandas_data_analytics/src/pandas_notes.py:231:# allows more space for column contents
./pandas_data_analytics/src/pandas_notes.py:24:# number of unique entries for the itemDescription column
./pandas_data_analytics/src/pandas_notes.py:2:# model_library = [k for k, v in _all_models.items() if v.is_turbo]
./pandas_data_analytics/src/pandas_notes.py:30:# convert date like field to a date type. 's' is for unix time stamp to date
./pandas_data_analytics/src/pandas_notes.py:4:# https://www.kaggle.com/herozerp/viz-rule-mining-for-groceries-dataset
./pandas_data_analytics/src/pandas_notes.py:64:# for 1 column
./pandas_data_analytics/src/pandas_notes.py:66:# for all columns and fills NaN with 0
./pandas_data_analytics/src/pandas_notes.py:87:# pd.concat((pd.read_csv(file) for file in files), ignore_index=True)
./pandas_data_analytics/src/pandas_notes.py:92:# pd.concat((pd.read_csv(file) for file in files), axis='columns')
EOF
)"
  assert_output "$expected"
  cd ..
}

@test "check find_in_files_fuzz 'cans' '.*\.py|.*\.fs' '3' for proper listing of occurrences with a file pattern filter and a max depth search of 3" {
  cd ./mock_content
  function f(){
    find_in_files_fuzz 'cans' '.*\.py|.*\.fs' '3' | sort -f
  }
  run f
  assert_success
expected="$(cat << EOF
./FslabDataAnalytics/utils/index.fs:6:let setFullPaths (fileLocations: Dictionary<string,string>) (dir: string) =
./FslabDataAnalytics/utils/index.fs:7:  for entry in fileLocations do
./FslabDataAnalytics/utils/index.fs:8:    fileLocations.[entry.Key] <- Path.Combine(dir, entry.Value)
./pandas_data_analytics/src/pandas_notes.py:122:# df['city'] = df['location'].str.split(', ', expand=True)[0]
./pandas_data_analytics/src/pandas_notes.py:44:# filtering df using a series, contains check. is in list .in() .contains()
EOF
)"
  assert_output "$expected"
  cd ..
}

