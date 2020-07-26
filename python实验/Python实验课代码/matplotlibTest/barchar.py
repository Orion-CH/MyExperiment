import numpy as np
import matplotlib.pyplot as plt

N = 5
y = [20, 10, 30, 25, 15]
index = np.arange(N)
plt.figure(1)
plt.bar(x=0, bottom=index, height=0.5, color='red', width=y, orientation='horizontal', align='center')

plt.figure(2)
plt.barh(y=index, height=0.5, width=y)
plt.show()
