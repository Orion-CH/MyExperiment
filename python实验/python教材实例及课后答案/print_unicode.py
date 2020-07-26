import sys
import unicodedata


def print_unicode_table(word):
    print("decimal   hex   chr  {0:^40}".format("name"))
    print("-------  -----  ---  {0:-<40}".format(""))

    code = ord(" ")  # 空格的unicode的值是32。从0xD800(55296)到0xDFFF(57343) 这段unicode是空的
    # end = sys.maxunicode #maxunicode是1114111，说明系统采用是ucs-4编码
    end = min(0xD800, sys.maxunicode)

    while code < end:
        c = chr(code)
        name = unicodedata.name(c, "*** unknown ***")  # 如果没有名字的话，用unkown代替
        if word is None or word in name.lower():
            print("{0:7}  {0:5X}  {0:^3c}  {1}".format(
                code, name.title()))
        code += 1


word = None
if len(sys.argv) > 1:
    if sys.argv[1] in ("-h", "--help"):
        print("usage: {0} [string]".format(sys.argv[0]))
        word = 0
    else:
        word = sys.argv[1].lower()
if word != 0:
    print_unicode_table(word)
