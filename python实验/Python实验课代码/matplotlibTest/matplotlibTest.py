import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(-1, 2, 50)
y1 = 2 * x + 1
y2 = x ** 2

plt.figure(num=3, figsize=(3, 3))  # figure开头之后就是和此figure有关的
plt.plot(x, y1, color='red', linewidth=2, linestyle='--')
# plt.figure()

plt.xlim((-1, 2))  # 设置坐标轴取值范围
plt.ylim((-2, 5))
plt.xlabel('I am x')  # 设置坐标轴的标注
plt.ylabel('I am y')

# ticks x轴坐标下标
new_ticks = np.linspace(-1, 2, 5)  # -1到2，分成5个单位
print(new_ticks)
plt.xticks(new_ticks)  # 设置x的ticks

# 设置文字的ticks(下标)
plt.yticks([-2, -1.5, -1, 1.22, 3],
           [r'$really\ bad$', r'$bad\ \alpha$', 'normal', 'good', 'really good'])
# 改变字体：用$，空格需要用\转义， 阿尔法的表示：\alpha（特殊符号的转义）

# gca = 'get current axis'
ax = plt.gca()
ax.spines['right'].set_color('none')  # spines脊梁->图的4个边框 color=none ->边框不显示
ax.spines['top'].set_color('none')
ax.xaxis.set_ticks_position('bottom')
ax.yaxis.set_ticks_position('left')
ax.spines['bottom'].set_position(('data', 0))  # outward, axes对齐方式百分之多少
ax.spines['left'].set_position(('data', 0))


plt.plot(x, y2)
plt.show()  # 脚本中需要show才能看到
