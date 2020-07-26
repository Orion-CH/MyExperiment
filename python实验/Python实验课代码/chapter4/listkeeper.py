import os

# 这个程序实现了把一个列表保存到文件中，并且可以通过图形化界面实现显示，增删，保存的功能

# 对get_string, get_integer的理解：目的还是为了得到输入的字符串或者数字，但是与直接用
# input不同的是，用这两个函数可以在输入的时候完成"默认选项"，"输入非法数值的时候报错"，
# "给定合法数值的条件"等等功能，使获取输入的功能更加强大，让程序的鲁棒性更强
YES = frozenset({"y", "Y", "yes", "Yes", "YES"})  # 一个固定集合


def main():
    dirty = False
    # 看当前操作是否需要保存，如果进行了添加，删除则把dirty设置为true，提示需要保存。
    # 进行保存了之后，则把dirty设置为false，表示不用保存了
    items = []

    filename, items = choose_file()
    if not filename:
        print("Cancelled")
        return

    while True:
        print("\nList Keeper\n")
        print_list(items)
        choice = get_choice(items, dirty)

        if choice in "Aa":
            dirty = add_item(items, dirty)
        elif choice in "Dd":
            dirty = delete_item(items, dirty)
        elif choice in "Ss":
            dirty = save_list(filename, items)
        elif choice in "Qq":
            if (dirty and (get_string("Save unsaved changes (y/n)",
                                      "yes/no", "y") in YES)):
                save_list(filename, items, True)
            break


def choose_file():
    # 函数说明：看当前目录是否有现成的列表文件。有的话则返回装有文件内容的链表，如果没有的话则返回一个空的列表
    enter_filename = False  # 是否需要创建新列表文件
    print("\nList Keeper\n")
    files = [x for x in os.listdir(".") if x.endswith(".lst")]  # 获取当前目录下的文件
    if not files:  # 没有找到存在.lst结尾的文件，则需要创建新的列表
        enter_filename = True

    if not enter_filename:  # 如果有文件了，就打印文件名称
        print_list(files)
        index = get_integer("Specify file's number (or 0 to create "
                            "a new one)", "number", maximum=len(files),
                            allow_zero=True)
        if index == 0:
            enter_filename = True
        else:
            filename = files[index - 1]  # 储存时是从0开始的
            items = load_list(filename)  # 将文件中的列表内容加载到列表之中
    if enter_filename:
        filename = get_string("Choose filename", "filename")
        if not filename.endswith(".lst"):
            filename += ".lst"
        items = []
    return filename, items


def print_list(items):
    if not items:
        print("-- no items are in the list --")
    else:
        width = 1 if len(items) < 10 else 2 if len(items) < 100 else 3
        # 根据文件名的长度，自动选取不同的空位数打印字符串
        for i, item in enumerate(items, start=1):
            print("{0:{width}}: {item}".format(i, **locals()))
    print()


def get_choice(items, dirty):
    while True:
        if items:
            if dirty:
                menu = "[A]dd  [D]elete  [S]ave  [Q]uit"
                valid_choices = "AaDdSsQq"
            else:
                menu = "[A]dd  [D]elete  [Q]uit"
                valid_choices = "AaDdQq"
        else:
            menu = "[A]dd  [Q]uit"
            valid_choices = "AaQq"
        choice = get_string(menu, "choice", "a")  # 默认是a

        if choice not in valid_choices:
            print("ERROR: invalid choice--enter one of '{0}'".format(
                valid_choices))
            input("Press Enter to continue...")
        else:
            return choice


def add_item(items, dirty):
    item = get_string("Add item", "item")
    if item:
        items.append(item)
        items.sort(key=str.lower)
        return True
    return dirty


def delete_item(items, dirty):
    index = get_integer("Delete item number (or 0 to cancel)",
                        "number", maximum=len(items),
                        # maximum是为了限制不能输入超过列表下标的元素
                        allow_zero=True)
    if index != 0:
        del items[index - 1]
        return True
    return dirty


def load_list(filename):
    items = []
    fh = None
    try:
        for line in open(filename, encoding="utf8"):
            items.append(line.rstrip())
    except EnvironmentError as err:
        print("ERROR: failed to load {0}: {1}".format(filename, err))
        return []
    finally:
        if fh is not None:
            fh.close()
    return items


def save_list(filename, items, terminating=False):  # terminating为false是指要不要在保存后停顿，输入回车后才继续
    # 1、要把列表的内容存进文件 2、如果保存成功，则返回false给dirty，说明不用再保存了。
    fh = None
    try:
        fh = open(filename, "w", encoding="utf8")
        fh.write("\n".join(items))  # 写的漂亮，一行代码就把一个列表内的多个字符串写入了文件
        fh.write("\n")
    except EnvironmentError as err:
        print("ERROR: failed to save {0}: {1}".format(filename, err))
        return True
    else:
        print("Saved {0} item{1} to {2}".format(len(items),
                                                ("s" if len(items) != 1 else ""), filename))
        if not terminating:
            input("Press Enter to continue...")
        return False
    finally:
        if fh is not None:
            fh.close()


def get_string(message, name="string", default=None,
               minimum_length=0, maximum_length=80):
    # defualt是在 没有输入时 返回的默认值，name是出现异常的时候用的

    message += ": " if default is None else " [{0}]: ".format(default)
    while True:
        try:
            line = input(message)
            if not line:
                if default is not None:
                    return default
                if minimum_length == 0:
                    return ""
                else:
                    raise ValueError("{0} may not be empty".format(
                        name))
            if not (minimum_length <= len(line) <= maximum_length):
                raise ValueError("{name} must have at least "
                                 "{minimum_length} and at most "
                                 "{maximum_length} characters".format(
                    **locals()))
            return line
        except ValueError as err:
            print("ERROR", err)


def get_integer(message, name="integer", default=None, minimum=0,
                maximum=100, allow_zero=True):

    class RangeError(Exception):
        pass
    # 用自定义异常代替了标记变量，使出错的信息更简单的被处理

    message += ": " if default is None else " [{0}]: ".format(default)
    while True:
        try:
            line = input(message)
            if not line and default is not None:
                return default
            i = int(line)
            if i == 0:
                if allow_zero:
                    return i
                else:
                    raise RangeError("{0} may not be 0".format(name))
            if not (minimum <= i <= maximum):
                raise RangeError("{name} must be between {minimum} "
                                 "and {maximum} inclusive{0}".format(
                    " (or 0)" if allow_zero else "", **locals()))
            return i
        except RangeError as err:
            print("ERROR", err)
        except ValueError as err:
            print("ERROR {0} must be an integer".format(name))


main()
