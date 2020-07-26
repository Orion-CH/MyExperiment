result = []
l = [1, 2, 3, [4, [5, 6, [7, 8, [9, 10]]]]]


def function(l, result):
    for i in l:
        if isinstance(i, list):
            function(i, result)
        else:
            result.append(i)


function(l, result)
print(result)
