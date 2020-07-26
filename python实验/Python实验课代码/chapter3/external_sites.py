
import sys


sites = {}
for filename in sys.argv[1:]:
    for line in open(filename):
        i = 0
        while True:
            site = None
            i = line.find("http://", i)
            if i > -1:
                i += len("http://")

                for j in range(i, len(line)):  # 网址起点的位置
                    if not (line[j].isalnum() or line[j] in ".-"):  # 如果不是ascii字符且不是'. -'  /
                        site = line[i:j].lower()
                        break

                if site and "." in site:
                    sites.setdefault(site, set()).add(filename)
                    # sites是个字典，第一个参数是key，如果没有则设置为第二个参数给的默认值
                i = j
            else:
                break

for site in sorted(sites):
    print("{0} is referred to in:".format(site))
    for filename in sorted(sites[site], key=str.lower):
        print("    {0}".format(filename))

