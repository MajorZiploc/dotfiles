#!/usr/bin/env ./libs/bats/bin/bats
load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source ~/.bashrc || true;

@test "check find_in_files '\bdf\.Columns' for proper listing of occurrences" {
  cd ./mock_content
  run find_in_files '\bdf\.Columns'
  assert_success
expected="$(cat << EOF
./pandas_data_analytics/src/body_comp/run.py:38:# exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp',c,re.I)).to_list()
./pandas_data_analytics/src/osrs/run.py:29:exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp', c, re.I)).to_list()
./pandas_data_analytics/src/osrs/run.py:94:exp_df: pd.DataFrame = df.loc[:, df.columns.isin(Enumerable(
./pandas_data_analytics/src/osrs/run.py:95:  df.columns).where(lambda c: re.match('.*exp', c)).to_list())]
./pandas_data_analytics/src/common_food/run.py:19:df.columns = df.columns.str.lower()
./pandas_data_analytics/src/utils/utils.py:6:  return [df.head(), df.dtypes, df.shape, df.columns, df.index]
./pandas_data_analytics/src/pokemon_learn_sets/run.py:149:  # print(df.columns)
./FslabDataAnalytics/FslabDataAnalytics/osrs/run.fs:30:        df.Columns.Keys
./FslabDataAnalytics/FslabDataAnalytics/osrs/run.fs:39:    printfn "%A" <| df.Columns.Keys
EOF
)"
  assert_output "$expected"
  cd ..
}

@test "check find_in_files '\bdf\.Columns' '.*(osrs|common).*\.py' for proper listing of occurrences with a file pattern filter" {
  cd ./mock_content
  run find_in_files '\bdf\.Columns' '.*(osrs|common).*\.py'
  assert_success
expected="$(cat << EOF
./pandas_data_analytics/src/osrs/run.py:29:exps = Enumerable(df.columns).where(lambda c: re.match('.*_exp', c, re.I)).to_list()
./pandas_data_analytics/src/osrs/run.py:94:exp_df: pd.DataFrame = df.loc[:, df.columns.isin(Enumerable(
./pandas_data_analytics/src/osrs/run.py:95:  df.columns).where(lambda c: re.match('.*exp', c)).to_list())]
./pandas_data_analytics/src/common_food/run.py:19:df.columns = df.columns.str.lower()
EOF
)"
  assert_output "$expected"
  cd ..
}

