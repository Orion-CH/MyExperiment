import collections
import sys

ID, FORENAME, MIDDLENAME, SURNAME, DEPARTMENT = range(5)

User = collections.namedtuple("User",
                              "username forename middlename surname id")


def main():
    if len(sys.argv) == 1 or sys.argv[1] in {"-h", "--help"}:
        print("usage: {0} file1 [file2 [... fileN]]".format(
            sys.argv[0]))
        sys.exit()

    usernames = set()
    users = {}
    for filename in sys.argv[1:]:  # 对输入对每个文件进行读取
        for line in open(filename, encoding="utf8"):
            line = line.rstrip()
            if line:
                user = process_line(line, usernames)
                users[(user.surname.lower(), user.forename.lower(),
                       user.id)] = user
    print_users(users)


def process_line(line, usernames):
    fields = line.split(":")
    username = generate_username(fields, usernames)
    user = User(username, fields[FORENAME], fields[MIDDLENAME],
                fields[SURNAME], fields[ID])
    return user


def generate_username(fields, usernames):
    username = ((fields[FORENAME][0] + fields[MIDDLENAME][:1] +
                 fields[SURNAME]).replace("-", "").replace("'", ""))
    username = original_name = username[:8].lower()
    count = 1
    while username in usernames:
        username = "{0}{1}".format(original_name, count)
        count += 1
    usernames.add(username)
    return username


def by_surname_forename(user):
    return user.surname.lower(), user.forename.lower(), user.id


def print_users(users):
    namewidth = 17
    usernamewidth = 9
    columngap = " " * 2

    headline1 = "{0:<{nw}} {1:^6} {2:{uw}}".format("Name", "ID",
                                                   "Username", nw=namewidth, uw=usernamewidth)
    headline2 = "{0:-<{nw}} {0:-<6} {0:-<{uw}}".format("",
                                                       nw=namewidth, uw=usernamewidth)
    header = (headline1 + columngap + headline1 + "\n" +
              headline2 + columngap + headline2)

    lines = []
    for key in sorted(users):
        # sorted排字典默认是按key进行排序的，users的key是一个(surname, forename, ID)的三元组，
        # 也就是先把第一个元素surname按照字典序进行排序，然后是forename，然后是ID
        user = users[key]  # user是一个包含username, forename, middlename, surname, ID的命名元组
        initial = ""
        if user.middlename:  # 如果有middlename
            initial = " " + user.middlename[0]
        name = "{0.surname}, {0.forename}{1}".format(user, initial)
        lines.append("{0:.<{nw}.{nw}} ({1.id:4}) "
                     "{1.username:{uw}}".format(name, user,
                                                nw=namewidth, uw=usernamewidth))

    lines_per_page = 64
    lino = 0
    for left, right in zip(lines[::2], lines[1::2]):  # zip返回一个迭代器，每次出来一个二元组
        if lino == 0:
            print(header)
        print(left + columngap + right)
        lino += 1
        if lino == lines_per_page:
            print("\f")
            lino = 0
    if lines[-1] != right:  #如刚刚zip只会把2个的元素一起变成元组，果是奇数个，则lines的最后一个元组将会单独出来
        print(lines[-1])


main()
