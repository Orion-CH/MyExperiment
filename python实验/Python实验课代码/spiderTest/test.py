import requests
import re

# 目标网页
Url = 'http://hm.people.com.cn/GB/230533/'
# 得到网页内容
response = requests.get(Url)
# print(response.text)
# exit()
response.encoding = 'GB2312'  # 看了一下网页源码的charset

html = response.text
# 获取每条新闻的的地址和标题
url_title = re.findall(r"<a href=\'(.*?)\' target=_blank>(.*?)</a>", html)

news = []

num = 1
f = open('港澳新闻', 'w', encoding='utf-8')

for url, title in url_title:
    final_url = 'http://hm.people.com.cn/{}'.format(url)  # 拼出了最终网址
    content_result = requests.get(final_url)
    content_result.encoding = 'GB2312'
    content_html = content_result.text

    # print(content_html)
    content_text = re.findall(r'<div class="box_pic"></div>(.*?)<div class="zdfy clearfix">', content_html, re.S)
    if len(content_text) != 0:  # 如果找到了文本数据
        content_text[0] = content_text[0].strip()
        i = content_text[0].find(r'</div>')
        if i != -1:  # 说明找到了，把标题裁掉
            content_text[0] = content_text[0][i + 6:]

        content_text[0] = content_text[0].replace('<p>', '')
        content_text[0] = content_text[0].replace('</p>', '')
        content_text[0] = content_text[0].replace(r'\u3000', '')
        content_text[0] = content_text[0].replace(r'\t', '')
        content_text[0] = content_text[0].replace(r'\n\n', r'\n')
        content_text[0] = content_text[0].replace('&nbsp', r'\n')
        content_text[0] = content_text[0].replace(r"\n;", '')

        content_text[0] = content_text[0].replace('<strong>', '\n')
        content_text[0] = content_text[0].replace('</strong>', '')
        content_text[0] = re.sub(r'<p style=".*?">', '', content_text[0])
        content_text[0] = re.sub(r'<img alt=.*?/>', '', content_text[0])
        content_text[0] = re.sub(r'<p align=.*?>', '', content_text[0])
        # content_text[0] = re.sub(r'<table class=".*?" width=".*?">*</table>', '', content_text[0], re.S)
        l = []
        l = re.findall(r'<table(.*?)</table>', content_text[0], re.S)
        if l:
            content_text[0] = content_text[0].replace('<table{}</table>'.format(l[0]), '')
        # 内容处理完毕
        # print(title)
        # print(content_text[0])

        f.write('{}、'.format(num))
        num += 1
        f.write(title)
        f.write(content_text[0])
        f.write('\n\n\n')
        print('#', end='')
        news.append((title, content_text[0]))

f.close()
print("\n文件写入完成！")
