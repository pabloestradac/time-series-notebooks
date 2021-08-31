import pandas as pd
import matplotlib.pyplot as plt

# load dataset using read_csv()
series = pd.read_csv('daily-total-female-births.csv', header=0, parse_dates=[0], index_col=0, squeeze=True)
print(type(series))

# summarize first few lines of a file
print(series.head())

# query a dataset using a date-time index
print(series['1959-01'])

# summarize the dimensions of a time series
print(series.size)

# create a line plot
series.plot()
plt.show()

# create a dot plot
series.plot(style='k.')
plt.show()

# create stacked line plots
groups = series.groupby(TimeGrouper('A'))
years = pd.DataFrame()
for name, group in groups:
  years[name.year] = group.values
years.plot(subplots=True, legend=False)
plt.show()

# create a histogram plot
series.hist()
plt.show()

# create a density plot
series.plot(kind='kde')
plt.show()

# create a boxplot of yearly data
groups = series.groupby(TimeGrouper('A'))
years = pd.DataFrame()
for name, group in groups:
  years[name.year] = group.values
years.boxplot()
plt.show()

# create a boxplot of monthly data
one_year = series['1990']
groups = one_year.groupby(TimeGrouper('M'))
months = pd.concat([pd.DataFrame(x[1].values) for x in groups], axis=1)
months = pd.DataFrame(months)
months.columns = range(1,13)
months.boxplot()
plt.show()

# create a heat map of yearly data
groups = series.groupby(TimeGrouper('A'))
years = pd.DataFrame()
for name, group in groups:
  years[name.year] = group.values
years = years.T
plt.matshow(years, interpolation=None, aspect='auto')
plt.show()

# create a scatter plot
import pandas.tools.plotting as pdtools
pdtools.lag_plot(series)
plt.show()

# create an autocorrelation plot
pdtools.autocorrelation_plot(series)
pyplot.show()













