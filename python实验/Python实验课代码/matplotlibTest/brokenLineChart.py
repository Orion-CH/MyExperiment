from datetime import datetime

import dateutil
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import time


# command + / 添加或取消注释
# 常用于观察变化
# safari command + r 刷新快捷键

def datestr2num(x):
    str_x = x.decode('utf-8')
    time_array = time.strptime(str_x, "%m/%d/%Y")  # 转时间数组
    return int(time.mktime(time_array))


date, open, close = np.loadtxt('000001.csv', converters={0: datestr2num}, delimiter=',', skiprows=1, usecols=(0, 1, 4),
                               unpack=True)

# converters参数, 这个是对数据进行预处理的参数, 我
# 们可以先定义一个函数， 这里的converters是一个字典, 表示第零列使用函数add_one来进行预处理
# 将第0行的内容按照month/day/year来分割
# 日期是比较特殊的数据，需要通过mdates转化为能识别的数字（其实是个浮点数）
# plt.plot(date, open)
# x = np.linspace(-10, 10, 100)
# y = x**2
#
# plt.plot(x, y)
# date是个ndarray数组,是时间戳

def strTompldates(timeStamp):
    timeArray = time.localtime(timeStamp)
    x = time.strftime("%m/%d/%Y", timeArray)
    return mdates.date2num(datetime.strptime(x, '%m/%d/%Y'))


matplotlib_dates = list(map(strTompldates, date)) # 把str->datetime->matplotlibdates

plt.plot_date(matplotlib_dates, open, linestyle='-', color='red', marker='o')  # 一个专门用来显示坐标轴为时间的函数，能把date(是个float)转化为时间, 默认是散点图
plt.plot_date(matplotlib_dates, close, linestyle='--', color='green', marker='<')
# plot_date主要参数：
# 线型 linestyle '-' '--'
# 颜色 color
# 点形状 marker: 'o' ->circle; '<' ->triangle
plt.show()
