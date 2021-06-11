import numpy as np
import pandas as pd
import seaborn as sns
from scipy import stats
import matplotlib.pyplot as plt

# filters out outliers by z score and IQR

# l = [41, 44, 46, 46, 47, 47, 48, 48, 49, 51, 52, 53, 53, 53, 53, 55, 55, 55,
#      55, 56, 56, 56, 56, 56, 56, 57, 57, 57, 57, 57, 57, 57, 57, 58, 58, 58,
#      58, 59, 59, 59, 59, 59, 59, 59, 59, 60, 60, 60, 60, 60, 60, 60, 60, 61,
#      61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 62, 62, 62, 62, 62, 62, 62, 62,
#      62, 63, 63, 63, 63, 63, 63, 63, 63, 63, 64, 64, 64, 64, 64, 64, 64, 65,
#      65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 66, 66, 66, 66, 66, 66, 66,
#      67, 67, 67, 67, 67, 67, 67, 67, 68, 68, 68, 68, 68, 69, 69, 69, 70, 70,
#      70, 70, 71, 71, 71, 71, 71, 72, 72, 72, 72, 73, 73, 73, 73, 73, 73, 73,
#      74, 74, 74, 74, 74, 75, 75, 75, 76, 77, 77, 78, 78, 79, 79, 79, 79, 80,
#      80, 80, 80, 81, 81, 81, 81, 83, 84, 84, 85, 86, 86, 86, 86, 87, 87, 87,
#      87, 87, 88, 90, 90, 90, 90, 90, 90, 91, 91, 91, 91, 91, 91, 91, 91, 92,
#      92, 93, 93, 93, 94, 95, 95, 96, 98, 98, 99, 100, 102, 104, 105, 107, 108,
#      109, 110, 110, 113, 113, 115, 116, 118, 119, 121]

# sns.distplot(l, kde=True, rug=False)

# plt.show()

print('zscore begin')

price = np.array([80, 71, 79, 61, 78, 73, 77, 74, 76, 75, 160, 79, 80,
                  78, 75, 78, 86, 80, 75, 82, 69, 100, 72, 74, 75, 180, 72, 71, 120])
price_df = pd.DataFrame(price)
price_df.columns = ['price']


z = np.abs(stats.zscore(price_df))

print(np.where(z > 3))

# print(z)

z_price = price_df[(z < 3).all(axis=1)]
print(price_df.shape, z_price.shape)


print('IQR begin')

Q1 = price_df.quantile(0.25)
Q3 = price_df.quantile(0.75)
IQR = Q3 - Q1
lowqe_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR
print(lowqe_bound)
print(upper_bound)

IQR_price = price_df[~((price_df < lowqe_bound) | (
    price_df > upper_bound)).any(axis=1)]
print(price_df.shape, IQR_price.shape)

sns.boxplot(x=price_df['price'])
plt.show()

sns.boxplot(x=z_price['price'])
plt.show()

sns.boxplot(x=IQR_price['price'])
plt.show()
