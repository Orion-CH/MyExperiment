import locale
locale.setlocale(locale.LC_ALL, "")
# 将python解释器的locale设置成shell环境的locale
import datetime
import optparse
import os

def main():
    counts = [0, 0]  # 统计文件和目录数量的
    opts, paths = process_options()  # 从命令行输入的获取选项的内容

    if not opts.recursive:  # 如果不是递归
        filenames = []
        dirnames = []
        for path in paths:
            if os.path.isfile(path):  # 判断路径是否为文件
                filenames.append(path)
                continue

            for name in os.listdir(path):
                if not opts.hidden and name.startswith("."):  # 隐藏文件以.开头，如果命令行参数又没有要求显示隐藏文件，那就跳过
                    continue
                fullname = os.path.join(path, name)  # 把目录和文件名合成一个路径
                if fullname.startswith("./"):  # 如果是当前文件夹下文件的名字，那么就直接打印，开头不用加./filename了
                    fullname = fullname[2:]

                if os.path.isfile(fullname):
                    filenames.append(fullname)  # 是文件，放入filenames的列表里
                else:
                    dirnames.append(fullname)  # 是目录，放入dirnames的列表里
        counts[0] += len(filenames)
        counts[1] += len(dirnames)
        process_lists(opts, filenames, dirnames)
    else:  # 如果要求递归显示
        for path in paths:
            for root, dirs, files in os.walk(path):
                # os.walk() （我发现它会自动在目录树上进行移动，以实现递归的效果）
                # 方法用于通过在目录树中游走输出在目录中的文件名，向上或者向下。
                # os.walk()
                # 方法是一个简单易用的文件、目录遍历器，可以帮助我们高效的处理文件、目录方面的事情。
                # 在Unix，Windows中有效。

                # path - - 是你所要遍历的目录的地址, 返回的是一个三元组(root, dirs, files)。
                # root ： 所指的是当前正在遍历的这个文件夹的本身的地址
                # dirs ： 是一个list ，内容是该文件夹中所有的目录的名字(不包括子目录)
                # files ： 同样是list, 内容是该文件夹中所有的文件(不包括子目录)
                if not opts.hidden:  # 如果不要求显示隐藏文件，去除掉以.开头的文件
                    dirs[:] = [dir for dir in dirs
                               if not dir.startswith(".")]

                filenames = []
                for name in files:
                    if not opts.hidden and name.startswith("."):
                        continue
                    fullname = os.path.join(root, name)
                    if fullname.startswith("./"):  # 如果是当前文件夹下文件的名字，那么就直接打印，开头不用加./filename了
                        fullname = fullname[2:]
                    filenames.append(fullname)
                counts[0] += len(filenames)
                counts[1] += len(dirs)
                process_lists(opts, filenames, [])

    print("{0} file{1}, {2} director{3}".format(  # 显示有多少个文件和文件夹
        "{0:n}".format(counts[0]) if counts[0] else "no",  # 如果文件计数器不为空，则打印数量，否则打印no file
        "s" if counts[0] != 1 else "",  # file的复数
        "{0:n}".format(counts[1]) if counts[1] else "no",  # 如果目录计数器不为空，则打印数量，否则打印no director
        "ies" if counts[1] != 1 else "y"))  # director的复数


def process_lists(opts, filenames, dirnames):  # 根据选项，处理filenames和dirnames
    keys_lines = []  # （orderkey, information）
    for name in filenames:  # 对文件列表中的每个文件
        modified = ""  # 修改时间
        if opts.modified:  # 如果是要显示修改时间
            try:
                modified = (datetime.datetime.fromtimestamp(
                    os.path.getmtime(name))  # 获取文件修改的时间
                            .isoformat(" ")[:19] + " ")  # ISO格式的时间
            except EnvironmentError:
                modified = "{0:>19} ".format("unknown")
        size = ""
        if opts.sizes:  # 如果是要显示文件大小
            try:
                size = "{0:>15n} ".format(os.path.getsize(name))  # 获取该文件的大小
            except EnvironmentError:
                size = "{0:>15} ".format("unknown")
        if os.path.islink(name):  # 如果是个链接，那么显示出真实的路径
            name += " -> " + os.path.realpath(name)

        # 这几个判断是为了满足不同的排序命令
        if opts.order in {"m", "modified"}:  # 按照修改时间排序
            orderkey = modified
        elif opts.order in {"s", "size"}:   # 按照大小排序
            orderkey = size
        else:  # 按照名称排序
            orderkey = name

        keys_lines.append((orderkey, "{modified}{size}{name}".format(  # 先显示修改时间，然后是大小，然后是名称
            **locals())))

    size = "" if not opts.sizes else " " * 15
    modified = "" if not opts.modified else " " * 20
    for name in sorted(dirnames):
        keys_lines.append((name, modified + size + name + "/"))  # key_lines里面每个元素是一个元组，第一个是目录的名字


    for key, line in sorted(keys_lines):  # key纯粹是为了sorted排序
        print(line)


def process_options():
    usage = """%prog [options] [path1 [path2 [... pathN]]]

The paths are optional; if not given . is used."""
    # usage 定义的是使用方法，%prog 表示脚本本身

    parser = optparse.OptionParser(usage=usage)
    parser.add_option("-H", "--hidden", dest="hidden",
                      action="store_true",  # 如果选了，那么hidden这一项变成true
                      help="show hidden files [default: off]")
    parser.add_option("-m", "--modified", dest="modified",
                      action="store_true",
                      help="show last modified date/time [default: off]")
    orderlist = ["name", "n", "modified", "m", "size", "s"]
    parser.add_option("-o", "--order", dest="order",
                      choices=orderlist,
                      help=("order by ({0}) [default: %default]".format(
                          ", ".join(["'" + x + "'" for x in orderlist]))))
    parser.add_option("-r", "--recursive", dest="recursive",
                      action="store_true",
                      help="recurse into subdirectories [default: off]")  # 递归显示子目录
    parser.add_option("-s", "--sizes", dest="sizes",
                      action="store_true",
                      help="show sizes [default: off]")
    parser.set_defaults(order=orderlist[0])  # 默认按照choice里的第一个，name排序
    opts, args = parser.parse_args()
    # parse_args()返回的两个值：
    # options，它是一个对象（optpars.xxxx），保存有命令行参数值。
    # 只要知道命令行参数名，如sizes，就可以访问其对应的值： options.sizes
    # args: 返回一个位置参数的列表

    # action有三种类型：
    # action = 'store'
    # 默认类型，可以忽略不写。用户必须给出一个明确的参数值，该类型定义了将实际参数值保存到dest指定变量中
    # action = 'store_true'
    # 用户不需给出参数值，该类型定义了将布尔值true保存到dest指定的变量中
    # action = 'store_false'
    # 用户不需给出参数值，该类型定义了将布尔值false保存到dest指定的变量中

    if not args:
        args = ["."]
    return opts, args


main()
