# filter
# model_library = [k for k, v in _all_models.items() if v.is_turbo]

# https://www.kaggle.com/herozerp/viz-rule-mining-for-groceries-dataset

# Show installed versions
# Shows pandas version
# pd.___version__
# Shows all dependency versions
# pd.show_versions()

# unique entries in a Series
# df.col_name.unique()

# show the dataframe column types
# df.dtypes

# show the dataframe shape, the number of columns and rows
# df.shape

# shows number of nan/null values per column
# df.isna().sum()

# number of unique entries for the itemDescription column
# len(df["itemDescription"].unique())

# get 5 random samples
# df[['event', 'date']].sample(5)

# convert date like field to a date type. 's' is for unix time stamp to date
# pd.to_datetime(df['date_like_field'], unit='s')

# get year of date and count the freq of each year
# x = df['date'].dt.year.value_counts()
# x.sort_index() sorts the x values?

# group by stuff -- NOTE: count is the number of rows per group
# df.groupby('event')['views'].agg['count', 'mean', 'sum'].sort_values('sum')

# a safer eval to parse a string
# import ast
# type(ast.literal_eval('[1,2,3]')) # outputs: list

# filtering df using a series, contains check. is in list .in() .contains()
# occ_counts = df['occ'].value_counts()
# top_occs = occ_counts[occ_counts >= 5].index
# filtered_df = df[df['occ'].isin(top_occs)]

# reverse order and reset index
# df.loc[::-1].reset_index(drop=True)

# reverse column order
# df.loc[:, ::-1]

# loc info
# df.loc[<row_selector>, <column_selector>]

# select columns by data type
# df.select_dtype(include='number')
# df.select_dtype(include=['number', 'category'])
# df.select_dtype(exclude=['number', 'category'])

# convert string to numbers with strings that do not look like numbers converted to NAN
# for 1 column
# pd.to_numeric(df['col'], errors='coerce')
# for all columns and fills NaN with 0
# df.apply(pd.to_numeric, errors='coerce').fillna(0)
# pd.to_numeric(df['col'], errors='coerce')

# memory reduction step
# only read the columns you need from a csv
# cols = ['a', 'b']
# df = pd.read_csv('path/to/csv.csv', usecols=cols)

# memory reduction step
# specify categories up front
# cols = ['a', 'b']
# dtypes = {'a: 'category'}
# df = pd.read_csv('path/to/csv.csv', usecols=cols, dtype=dtypes)

# show memory usage of df
# df.info(memory_usage='deep')

# read from multiple csv's into 1 df (row wise)
# from glob import glob
# files = sorted(glob('data/stocks*.csv'))
# pd.concat((pd.read_csv(file) for file in files), ignore_index=True)

# read from multiple csv's into 1 df (column wise)
# from glob import glob
# files = sorted(glob('data/stocks*.csv'))
# pd.concat((pd.read_csv(file) for file in files), axis='columns')

# read data from clipboard
# df = pd.read_clipboard()

# split a dataframe into 2 random subsets
# df1 = df.sample(frac=0.75, random_state=1234)
# df2 = df.drop(df1.index)
# df1.index.sort_values()
# df2.index.sort_values()

# filter a dataframe by multiple categories
# df[df['genre'].isin(['action', 'scifi'])]

# Filter a dataframe by the largest categories
# counts = df['genre'].value_counts()
# counts.nlargest(3).index
# df[df['genre'].isin(counts.nlargest(3).index)]

# Handle missing values
# total columns with mv
# df.isna().sum()
# percentage of mv
# df.isna().mean()
# drop columns where more than 10% of values are missing
# df.dropna(thresh=len(df)*0.9, axis='columns')

# split a string into multiple columns
# df[['first', 'middle', 'last']] = df['name'].str.split(' ', expand=True)
# save only the first of the split columns
# df['city'] = df['location'].str.split(', ', expand=True)[0]

# example a series of lists into a dataframe
# df2 = df1['col_two'].apply(pd.Series)
# df3 = pd.concat([df1, df2], axis='columns')

# combine the output of an aggregation with a dataframe
# total_price = df.groupby('order_id')['item_price'].transform('sum')
# len(total_price)
# df['total_price'] = total_price
# df['percent_of_total'] = df['item_price'] / df['total_price']

# select a slice of rows and columns describes
# df.describe().loc(['min':'max'])
# slice the stats by columns aswell
# df.describe().loc(['min':'max', 'Pclass': 'Parch'])

# reshape a multi indexed series (multi index refers to having multi grouped series/df)
# df.groupby(['Sex', 'Pclass'])['Survived'].mean()
# df.groupby(['Sex', 'Pclass'])['Survived'].mean().unstack()

# create a pivot table like performing the unstack above!!
# df.pivot_table(index='Sex', columns='Pclass', values='Survived', aggfunc='mean')
# shows overall survival rate aswell
# df.pivot_table(index='Sex', columns='Pclass', values='Survived', aggfunc='mean', margins=True)

# convert continuonus data into categorical data
# pd.cut(df['Age'], bins=[0,18,25,99], labels=['child', 'young adult', 'adult'])

# change display options
# all floats will use 2 dec places
# pd.set_option('display.float_format', '{:.2f}'.format)
# resets the float format back to default
# pd.reset_option('display.float_format')

# style a dataframe
# format_dict = {'Date': '{:%m/%d/%y}', 'Close': '${:.2f}', 'Volume': '{:,}'}
# stocks.style.format(format_dict)
# (stocks.style.format(format_dict)
#   .hide_index()
#   .highlight_min('Close', color='red')
#   .highlight_max('Close', color='lightgreen')
# )

# Profile a dataframe. Amazing!!! Shows correlations, general info and plots of the dataframe
# seems to rely on Jupiter notebooks
# import pandas_profiling
# pandas_profiling.ProfileReport(df)


# get value counts as a percentage
# df['genre'].value_counts(normalize=True)
# df.groupby('driver_gender')['violation'].value_counts(normalize=True)

# combine string columns that rep a date time together
# df['date'] = df['stop_date'].str.cat(df['stop_time'], sep=' ')
# df['stop_datetime'] = pd.to_datetime(df['date'])
# df['stop_datetime'].dt.year

# groupby can also work with pandas expressions as the groupby subject
# df.groupby(df['stop_datetime'].dt.hour)['drugs_related_stop'].agg(['mean'])

# .sort_index to sort by index of a series. sorts by hour here
# df['stop_datetime'].dt.hour.value_counts().sort_index()

# df filter conditions: (~ is not, & is and, and | is or)

# df value assignment. requires use of loc
# matches rows that match the conditions around '1' and '2' and the column 'stop_duration'
# import numpy as np
# df.loc[((df['stop_duration'] == '1') | (df['stop_duration'] == '2')), 'stop duration'] = np.nan

# counts all rows regardless of index value
# len(df)
# counts all rows with a unique index value
# len(df.index.value_counts()),

# subtract prev value from current value and store in new column
# dfe = pd.DataFrame({"Col1": [10, 20, 15, 30, 45],
#                    "Col2": [13, 23, 18, 33, 48],
#                    "Col3": [17, 27, 22, 37, 52]},
#                   index=pd.date_range("2020-01-01", "2020-01-05"))
# dfe['Col4'] = dfe.Col3.shift(1) - dfe.Col3

# datetime column from a Dataframe
# df = pd.DataFrame([[12,25,2017,10],[1,15,2018,11]],\
#                   columns=['month', 'day', 'year', 'hour']
#                 )
# df['datetime'] = pd.to_datetime(df)
# df['date'] = pd.to_datetime(df[['month', 'day', 'year']])

# overwrite the index .index
# df.index = df.col_num

# convert data types multiple rows at once, astype()
# df = df.astype({'colA':'float', 'colB':'float'})

# .agg() works on groupby, series, and dataframe!
# .agg() on dataframe can be a more flexible replacement to .describe() bcuz you can give custom fns to .agg()

# get the column with the max value in a row
# drinks = pd.read_csv('http://bit.ly/drinksbycountry')
# drinks.loc[:, 'beer_servings':'wine_servings'].apply(np.argmax, axis=1)

# creating bins in a dynamic way based on the min and max values and in steps of 5
# bins = np.linspace(df['Global_Sales'].min(), df['Global_Sales'].max(),  5)


#### QT CONSOLE #####
# allows more space for column contents
# pd.set_option('display.max_colwidth', 200)

# themes:
# dark
# ink-plot
# monokai
# stata-dark
# parais-dark
# light
# perl-doc
