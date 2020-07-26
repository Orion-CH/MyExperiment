import sys
import unicodedata


def print_unicode_table(words):
    print("decimal   hex   chr  {0:^40}".format("name"))
    print("-------  -----  ---  {0:-<40}".format(""))

    code = ord(" ")  # 空格的unicode的值是32。从0xD800(55296)到0xDFFF(57343)码位区段是永久保留不映射到Unicode字符
    # end = sys.maxunicode #maxunicode是1114111，说明系统采用是ucs-4编码
    end = min(0xD800, sys.maxunicode)

    while code < end:
        c = chr(code)
        name = unicodedata.name(c, "*** unknown ***")  # chr() 用一个范围在 range（256）内的（就是0～255）整数作参数，返回一个对应的字符
        num = 0
        sum = 1
        if words is not None:
            num = len(words)  # 有多少个单词
            sum = 0  # 出现在描述里的单词数
            for i in words:  # 如果单词出现在描述中
                if i in name.lower():
                    sum += 1

        if words is None or sum == num:
            print("{0:7}  {0:5X}  {0:^3c}  {1}".format(
                code, name.title()))
        code += 1


words = []
if len(sys.argv) > 1:
    if sys.argv[1] in ("-h", "--help"):
        print("用法: {0} [string]".format(sys.argv[0]))
        words = 0
    else:
        print(type(words))
        for i in sys.argv[1:]:
            words.append(i.lower())

if words != 0:
    print_unicode_table(words)
