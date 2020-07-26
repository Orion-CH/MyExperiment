# coding=utf-8
import numpy as np
import matplotlib.pyplot as plt
'''
height = [161, 170, 182, 175, 173, 165]
weight = [50, 58, 80, 70, 69, 55]
'''
N = 1000
x = np.random.randn(N)
y = x + np.random.randn(N)*0.5

plt.figure()
plt.scatter(x, y, s=100, c='r', marker='<', alpha=0.5)  # 画出来两个的散点图

# 散点图：研究两种变量的相关性(正负，不相关)
# 在命令行下打开iPython,用魔术命令 %run filename.py打开图
# 散点图的外观调整
'''
s是面积的意思，不是直径
c是color,(red)
marker o->圆形 <是三角形
alpha ->透明度(感受点在哪里集中，在哪里更稀疏)
'''
plt.show()