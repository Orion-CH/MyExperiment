
encode = str.maketrans("abcdefghijklmnopqrstuvwxyz", "bcdefghijklmnopqrstuvwxyza")  # 建立加密映射
text = input("请输入要进行加密的一串字母：")
encrypted_text = text.translate(encode)
print("加密后的结果为：{}\n".format(encrypted_text))

decode = str.maketrans("bcdefghijklmnopqrstuvwxyza","abcdefghijklmnopqrstuvwxyz")
text = input("请输入要进行解密的一串字母：")
decoded_text = text.translate(decode)
print("解密后的结果为：{}\n".format(decoded_text))