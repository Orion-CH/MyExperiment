import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

date, open, close = np.loadtxt('000001.csv', delimiter=',', converters = {0: mdates.bytespdate2num('%m/%d/%Y')},
                               skiprows=1, usecols=(0, 1, 4), unpack=True)
plt.plot_date(date, open)
plt.show()