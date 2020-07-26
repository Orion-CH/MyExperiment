import sys
import xml.sax.saxutils


def main():
    maxwidth, format = process_options()
    print_start()
    count = 0
    while True:
        try:
            line = input()
            if count == 0:
                color = "lightgreen"
            elif count % 2:
                color = "white"
            else:
                color = "lightyellow"
            print_line(line, color, maxwidth, format)
            count += 1  # 完成不同列颜色的变化（通过给print_line传入不同的参数)
        except EOFError:
            break
    print_end()


def print_start():
    print("<table border='1'>")


def print_line(line, color, maxwidth, format):
    print("<tr bgcolor='{0}'>".format(color))  # 根据传入的不同参数设置行的背景色
    numberFormat = "<td align='right'>{{0:{0}}}</td>".format(format)  # 分两步格式化，第一次把浮点数的格式放到一个格式化输出的字符串里
    fields = extract_fields(line)
    for field in fields:
        if not field:
            print("<td></td>")
        else:
            number = field.replace(",", "")
            try:
                x = float(number)
                #print("<td align='right'>{0:d}</td>".format(round(x)))
                print(numberFormat.format(x))  # 第二次再把字符串内容补全
            except ValueError:
                field = field.title()
                field = field.replace(" And ", " and ")
                if len(field) <= maxwidth:
                    field = xml.sax.saxutils.escape(field)
                else:
                    field = "{0} ...".format(
                        xml.sax.saxutils.escape(field[:maxwidth]))
                print("<td>{0}</td>".format(field))
    print("</tr>")


def extract_fields(line):  # 传入一行csv格式的字符串，返回一个包含各个单词的列表
    fields = []
    field = ""
    quote = None
    for c in line:
        if c in "\"'":  # 是否是"或者'
            if quote is None:  # 冒号是空的
                quote = c
            elif quote == c:  # 引号的结束，说明一个引号内的词被采完了
                quote = None
            else:
                field += c
            continue
        if quote is None and c == ",":  # 一个字段的结束
            fields.append(field)
            field = ""
        else:
            field += c  # 把字符c累加到字段里面
    if field:
        fields.append(field)  # 添加最后一个字段
    return fields


'''
def escape_html(text):  # 防止字符内容被浏览器当作html语句进行解析
    text = text.replace("&", "&amp;")
    text = text.replace("<", "&lt;")
    text = text.replace(">", "&gt;")
    return text
'''


def print_end():
    print("</table>")


def process_options():
    maxwidth_arg = "maxwidth="
    format_arg = "format="
    maxwidth = 100  # 默认的最大宽度
    format = ".0f"  # 默认的格式
    for arg in sys.argv[1:]:  # 挨个遍历命令行参数
        if arg in ["-h", "--help"]:
            print((""""\
用法:
csv2html.py [maxwidth=int] [format=str] < 输入csv文件的名字.csv > 输出html文件的名字.html

maxwidth 参数是一个可选的整数: 如果指定了，其代表可以被放到table单元格里面最长的字符数; 如果没有指定，则会默认使用{0}


format 参数是一个用来给单元格中数字做格式化输出的格式。如果没有指定，则会默认使用： "{1}"。""".format(maxwidth, format)))
            return None, None
        elif arg.startswith(maxwidth_arg):
            try:
                maxwidth = int(arg[len(maxwidth_arg):])
            except ValueError:
                pass
        elif arg.startswith(format_arg):
            format = arg[len(format):]
    return maxwidth, format



main()
