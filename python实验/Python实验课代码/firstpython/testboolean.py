import unicodedata
def hanoi(a, b, c, n):  # a to c through b
    if n == 2:
        print('{}->{}'.format(a, b))
        print('{}->{}'.format(a, c))
        print('{}->{}'.format(b, c))
    elif n == 1:
        print('{}->{}'.format(a, c))
    else:
        hanoi(a, c, b, n - 1)
        hanoi(a, b, c, 1)
        hanoi(b, a, c, n - 1)


# hanoi('a', 'b', 'c', 3)
c = chr()
name = unicodedata.name(c, "*** unknown ***")
print(name)