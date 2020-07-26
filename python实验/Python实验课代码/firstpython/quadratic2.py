import cmath
import math
import sys


def get_float(msg):  # , allow_zero):
    x = None
    while x is None:
        try:
            x = float(input(msg))
            '''
            if not allow_zero and abs(x) < sys.float_info.epsilon:  # sys.float_info.epsilon是机器可以区分出的两个浮点数的最小区别
                print('zero is not allowed')
                x = None
            '''
        except ValueError as err:
            print(err)
    return x


print('ax\N{SUPERSCRIPT TWO} + bx +c = 0')
a = get_float('enter a:')  # , False)
b = get_float('enter b:')  # , True)
c = get_float('enter c:')  # , True)
x1 = None
x2 = None
if abs(a) < sys.float_info.epsilon:
    if b != 0:
        x1 = -(c/b)
    elif c == 0:
        x1 = "任意实数"
    else:
        x1 = "无实数解"
else:
    discriminant = (b ** 2) - (4 * a * c)
    if discriminant == 0:
        x1 = -(b / (2 * a))
    else:
        if discriminant > 0:  # 有2个实数解
            root = math.sqrt(discriminant)
        else:  # 无实数解
            root = cmath.sqrt(discriminant)
        x1 = (-b + root) / (2 * a)
        x2 = (-b - root) / (2 * a)


equation = ''
if abs(a)<sys.float_info.epsilon:  # a为0
    pass
else:
    equation = '{}x\N{SUPERSCRIPT TWO} '.format(a)

if b > 0:
    equation += '+ {}x '.format(b)
elif abs(b)<sys.float_info.epsilon:  # b为0
    pass
else:
    equation += '- {}x '.format(abs(b))
if c > 0:
    equation += '+ {}'.format(c)
elif abs(c)<sys.float_info.epsilon:  # c为0
    pass
else:
    equation += '- {}'.format(abs(c))

if abs(a) < sys.float_info.epsilon and abs(b) < sys.float_info.epsilon and abs(c) < sys.float_info.epsilon:
    equation += '0'
equation += ' = 0  \N{RIGHTWARDS ARROW}  x = {}'.format(x1)

if x2 is not None:
    equation += ' or x = {0}'.format(x2)
print(equation)
