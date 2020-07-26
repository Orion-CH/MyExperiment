import Image

border_color = '#FF0000'  # 边框颜色： 红
square_color = '#0000FF'  # 中间方形的颜色： 蓝
width, height = 70, 50  # 5, 5
midx, midy = width // 2, height // 2
image = Image.Image(width, height, 'square_eye.image')
for x in range(width):
    for y in range(height):
        if x < 5 or x > width - 5 or y < 5 or y > height - 5:  # 画边框
            image[x, y] = border_color
        elif midx - 20 < x < midx + 20 and midy - 20 < y < midy + 20:  # 在中间画方形
            image[x, y] = square_color

image.print_image(border_color, square_color)
input('\n\n\n任意键继续\n\n\n')
image.resize(10, 10)  # 从大变小，从小变大
print()
image.print_image(border_color, square_color)

image.save()
