import string
# 大文件读取使用with open节省内存
name_dict = {}
gender = input("请输入性别：")
with open('boys_name' if gender=='男' else 'girls_name', 'r') as fb:
    for i in [1999, 2000, 2001]:
        for j in range(12):
            for k in range(31):
                for l in range(24):
                    line = fb.readline()
                    if line:
                        name_dict[(i, j+1, k+1, l+1)] = line

y, m, d, h = input("请输入出生的年，月，日，时（空格隔开）：").split()
print("生成的名字为："+name_dict[(int(y), int(m), int(d), int(h))])
