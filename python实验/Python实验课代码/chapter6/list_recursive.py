
mix = [1, [2, 3, [4, [5, 6]]]]
_ = []


def recur(mix, res):
    for x in mix:
        if isinstance(x, list):
            recur(x, res)
        else:
            res.append(x)


recur(mix, _)
print(_)
