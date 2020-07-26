import numpy as np
import matplotlib.pyplot as plt

open, close = np.loadtxt('000001.csv', delimiter=',',
                         skiprows=1, usecols=(1, 4), unpack=True)
# dilimiter -> 界定符
# open -> 开盘价，close -> 收盘价
change = open - close
# 程序此处可以打开ipython，运行%run 文件名.py ，再用change.shape查看change有多少个数据

yesterday = change[:-1]
today = change[1:]

plt.scatter(yesterday, today)

plt.show()