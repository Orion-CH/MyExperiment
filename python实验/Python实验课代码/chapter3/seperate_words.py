# coding=utf-8

s = "ILoveStudyStudyMakesMeHappy"
result = []

for k in s:
    result.append(k)

# 当前result = ['I', 'L', 'o', 'v', 'e', 'S', 't', 'u', 'd', 'y', 'S', 't', 'u', 'd', 'y', 'M', 'a', 'k', 'e', 's', 'M', 'e', 'H', 'a', 'p', 'p', 'y']

i = 1
while i < len(result):
    if result[i].isupper():  # 如果是大写，加空格
        result[i-1:i] = [result[i-1], ' ']
        i += 1
    i += 1
# 当前result = ['I', ' ', 'L', 'o', 'v', 'e', ' ', 'S', 't', 'u', 'd', 'y', ' ', 'S', 't', 'u', 'd', 'y', ' ', 'M', 'a', 'k', 'e', 's', ' ', 'M', 'e', ' ', 'H', 'a', 'p', 'p', 'y']

for i in range(len(result)):
    if (i is not 0) and result[i].isupper():
        print(str(result[i].lower()), end="")
    else:
        print(str(result[i]), end="")
# I love study study makes me happy
print("\n")
