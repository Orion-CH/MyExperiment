import collections
import string
import sys


# def order(item):
#     return item[1]


words = collections.defaultdict(int)
strip = string.whitespace + string.punctuation + string.digits + "\"'"
for filename in sys.argv[1:]:
    for line in open(filename):
        for word in line.lower().split():
            word = word.strip(strip)
            if len(word) > 2:
                words[word] = words.get(word, 0) + 1
for word in sorted(words.items(), key=lambda x: x[1], reverse=True):  # words是个字典，单词+出现次数
    print("'{0}' occurs {1} times".format(word[0], words[word[0]]))
# 每个word是个元组
